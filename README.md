# Android Review Dist

Repo này chỉ chứa artifact phát hành của `android-review`.

## Cài Đặt Lần Đầu

Tải file mới nhất trong thư mục `releases/`, giải nén, rồi chạy:

```text
install.command
```

## Cấu Hình Upgrade

Sau khi cài, chạy một lần:

```bash
android-review set-update-url https://raw.githubusercontent.com/taptura-studio/android-review-dist/main/latest.json
```

Các lần sau chỉ cần:

```bash
android-review upgrade
```

## Kiểm Tra

```bash
android-review version
android-review doctor
```

## Release Hiện Tại

```text
0.1.19
```

SHA256:

```text
e8d47b4768e486fa0912331b84d8a56830cae1f3680c6f2b331cd229be7187e6
```
