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
0.1.17
```

SHA256:

```text
9178713c3b6c80c50f04c3f795852be21d4717423b8b5dc5f01a5ff588bc9e3b
```
