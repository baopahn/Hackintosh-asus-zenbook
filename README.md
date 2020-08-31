# Hackintosh-asus-zenbook-ux430

## Cấu hình máy:
- CPU: Intel core I5-7200U
- GPU: Intel graphics 620
- Wifi: Intel AC8260
- Audio: Realtek ALC295

## Một vài công cụ cần để hỗ trợ hoàn thiện hackintosh:
- Hackintool
- Clover configurator

## Fix một số lỗi quan trọng:
### 1. Wifi:
- Trong bộ **EFI** đã cài sẵn kext để sử dụng wifi đối với những máy sử dụng card wifi của intel. Nhưng để kích hoạt được wifi thì cần phải dùng app có tên **HeliPort**.
- Đối với các bạn có thể cắm mạng LAN thì dễ dàng cài đặt app, nhưng đối với các bạn không thể xài mạng LAN thì có thể dùng giải pháp sử dụng thêm 1 laptop Window và làm như sau:
    - 1. Tải app **MacDrive** vào máy window (App cho phép window đọc được các phân vùng định dạng của macOS).
    - 2. Dùng macOS (máy đang hackintosh), mở app **Disk Utility** rồi format lại usb theo định dạng **HFS+**.
    - 3. Sau đó tải app **Heliport** về máy window, copy vào usb.
    - 4. Cắm usb vào lại máy đang hackintosh và tiến hành cài đặt app **Heliport**.
- Một số lỗi thường gặp khi không connect được wifi:
    - **Lỗi sai mật khẩu**: hãy cố gắng đảm bảo bạn đã nhập đúng mật khẩu.


### 2. Audio: (Headphone)
- **Lỗi méo âm, mất âm thanh khi sleep, cắm lại tai nghe thì mất âm thanh**.
---
- Cách giải quyết:
    - **B1:** Hãy đảm đang để **layout** của **AppleALC** là **14**.
    - **B2:** Tiến hành tải **ALCPlugfix** của **hieplpvip**.
    - **B3:** Cài đặt **ALCPlugfix** theo hướng dẫn của **hieplpvip**.
    - **B4:** Tải kext **Codeccomander** và bỏ vào **LE (Library/Extensions)**.
    - **B5:** Restart lại máy.
---
- Lỗi hay gặp ở bước 3:
    - **1. Báo lỗi không thể copy file vào trong usr/bin. Lúc này bạn cần tiến hành copy file bằng tay**.
        - **B1:** Mở terminal, nhập lệnh: **"sudo mount -uw /"** và **"sudo killall Finder"**. 2 lệnh này mục đích để cho phép bạn copy file vào **usr/bin**.
        - **B2:** Mở thư mục **alc_fix** trong thư mục tải về của **hieplpvip**, copy 2 file **ALCPlugfix** và **hda_verb** vào **usr/bin**.
        - **B3:** Copy file **good.win.ALCPlugFix.plist** vào **Library/LaunchAgents**.
        - **B4:** Chạy lại file **install.sh** của hieplpvip.
        - **B5:** Restart lại máy.
    - 2. Nếu âm thanh vẫn chưa được fix:
        - B1. Tiến hành tải xcode.
        - B2. Mở project ALCPlugFix.xcodeproj.
        - B3. Chạy project.
        - B4. Nhấp chuột phải vào file ALCPlugfix (trong thư mục Products) bên góc trên tay trái màn hình, chọn Show in folder.
        - B5. Copy file ALCPlugfix vừa chạy được vào usr/bin.
        - B6. Restart lại máy.

