#!/usr/bin/env bash
set -euo pipefail

LATEST_URL="${ANDROID_REVIEW_LATEST_URL:-https://raw.githubusercontent.com/taptura-studio/android-review-dist/main/latest.json}"
INSTALL_ROOT="${HOME}/.android-review-agent"
TARGET_DIR="${INSTALL_ROOT}/binary-current"
BIN_DIR="${HOME}/.local/bin"
LINK_PATH="${BIN_DIR}/android-review"

need_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Missing required command: $1" >&2
    exit 1
  fi
}

json_value() {
  local key="$1"
  python3 -c 'import json,sys; print(json.load(sys.stdin).get(sys.argv[1], ""))' "$key"
}

need_cmd curl
need_cmd python3
need_cmd shasum
need_cmd unzip

tmp_dir="$(mktemp -d "${TMPDIR:-/tmp}/android-review-install.XXXXXX")"
cleanup() {
  rm -rf "${tmp_dir}"
}
trap cleanup EXIT

echo "Android Review Installer"
echo "- Manifest: ${LATEST_URL}"

manifest_path="${tmp_dir}/latest.json"
curl -fsSL "${LATEST_URL}" -o "${manifest_path}"

version="$(json_value version < "${manifest_path}")"
package_url="$(json_value url < "${manifest_path}")"
expected_sha="$(json_value sha256 < "${manifest_path}")"

if [[ -z "${version}" || -z "${package_url}" || -z "${expected_sha}" ]]; then
  echo "Invalid latest.json: missing version, url, or sha256" >&2
  exit 1
fi

zip_path="${tmp_dir}/android-review.zip"
extract_dir="${tmp_dir}/extract"

echo "- Version: ${version}"
echo "- Downloading package"
curl -fL "${package_url}" -o "${zip_path}"

actual_sha="$(shasum -a 256 "${zip_path}" | awk '{print $1}')"
if [[ "${actual_sha}" != "${expected_sha}" ]]; then
  echo "SHA256 mismatch" >&2
  echo "Expected: ${expected_sha}" >&2
  echo "Actual  : ${actual_sha}" >&2
  exit 1
fi
echo "- SHA256: verified"

mkdir -p "${extract_dir}"
unzip -q "${zip_path}" -d "${extract_dir}"

runtime_dir=""
while IFS= read -r version_file; do
  candidate="${version_file%/_internal/VERSION}"
  if [[ -x "${candidate}/android-review" || -f "${candidate}/android-review" ]]; then
    runtime_dir="${candidate}"
    break
  fi
done < <(find "${extract_dir}" -path '*/_internal/VERSION' -print)

if [[ -z "${runtime_dir}" || ! -x "${runtime_dir}/android-review" ]]; then
  echo "Cannot find android-review runtime in downloaded package" >&2
  exit 1
fi

installed_version="$("${runtime_dir}/android-review" version)"
if [[ "${installed_version}" != "${version}" ]]; then
  echo "Downloaded runtime version mismatch: expected ${version}, got ${installed_version}" >&2
  exit 1
fi

mkdir -p "${INSTALL_ROOT}" "${BIN_DIR}"
if [[ -d "${TARGET_DIR}" ]]; then
  current_version="$("${TARGET_DIR}/android-review" version 2>/dev/null || printf 'unknown')"
  backup="${INSTALL_ROOT}/binary-current.backup-${current_version}-$(date +%Y%m%d%H%M%S)"
  mv "${TARGET_DIR}" "${backup}"
  echo "- Backup: ${backup}"
fi

cp -R "${runtime_dir}" "${TARGET_DIR}"
chmod +x "${TARGET_DIR}/android-review"
xattr -cr "${TARGET_DIR}" 2>/dev/null || true
ln -sf "${TARGET_DIR}/android-review" "${LINK_PATH}"

echo "- Installed: ${TARGET_DIR}"
echo "- Command: ${LINK_PATH}"
echo
echo "Done. Open a new Terminal if needed, then run:"
echo "  android-review version"
echo "  android-review doctor"
