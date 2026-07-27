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
0.1.18
```

SHA256:

```text
0efa5240a2b1a83e7e9ef5f0a4d791e8f0fc66fda295abcb71a2ab90b51e7c6e
```
