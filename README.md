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

## Ví Dụ Review

```bash
android-review /path/to/project --scope ads
android-review git@github.com:org/app.git release/1.0.3 --scope all
android-review SM_Funply --scope resources --ai none
```

Scope `ads` chỉ chạy pipeline ads-related và sinh thêm `ads_flow_map.json` kèm bảng placement/show/preload/cache/reward trong HTML report.

## Release Hiện Tại

```text
0.1.42
```

SHA256:

```text
ff00eb35e0062329356c91a65adc5b105af1d51f26a163579ee5c85828b5e358
```
