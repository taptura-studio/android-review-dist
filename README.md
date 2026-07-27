# Android Review Dist

Repo này chỉ chứa artifact phát hành của `android-review`.

## Cài Đặt Một Lệnh

Chạy trong Terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/taptura-studio/android-review-dist/main/install.sh | bash
```

## Cập Nhật

Từ bản `0.1.19` trở đi, chỉ cần:

```bash
android-review upgrade
```

Tool đã có sẵn update URL mặc định, không cần `set-update-url`.

## Cài Đặt Thủ Công

Tải file mới nhất trong thư mục `releases/`, giải nén, rồi chạy:

```text
install.command
```

## Kiểm Tra

```bash
android-review version
android-review doctor
```

## Release Hiện Tại

```text
0.1.23
```

SHA256:

```text
a611ef8e2d2b475661160a7f511926ad266ce52dfb484c668d89d4b340d03a73
```
