# Hackintosh-asus-zenbook-ux430

## Các cộng đồng, trang web hướng dẫn hackintosh
- Cộng đồng [hackintosh VNO](https://www.facebook.com/groups/vnohackintosh/?epa=SEARCH_BOX)
- Trang web [vnohackintosh.com](https://vnohackintosh.com)
- Trang web [hackintosh.vn](https://hackintosh.vn)

## Cấu hình máy:

|   Thuộc tính  |       Thông số      |
|:-------------:|---------------------|
|      CPU      | Intel core I5-7200U |
|      GPU      | Intel graphics 620  |
|      RAM      | 4GB                 |
|      Wifi     | Intel AC8260        |
|      Audio    | Realtek ALC295      |

## Một vài công cụ cần để hỗ trợ hoàn thiện hackintosh:
- [Hackintool]()
- [Clover configurator]()

## Fix một số lỗi quan trọng:
### 1. Wifi:
- Trong bộ **`EFI`** đã cài sẵn kext để sử dụng wifi đối với những máy sử dụng card wifi của intel. Nhưng để kích hoạt được wifi thì cần phải dùng app có tên **`HeliPort`**.
- Đối với các bạn có thể cắm mạng LAN thì dễ dàng cài đặt app, nhưng đối với các bạn không thể xài mạng LAN thì có thể dùng giải pháp sử dụng thêm 1 laptop Window và làm như sau:
    - **B1:** Tải app **`MacDrive`** vào máy window (App cho phép window đọc được các phân vùng định dạng của macOS).
    - **B2:** Dùng macOS (máy đang hackintosh), mở app **`Disk Utility`** rồi format lại usb theo định dạng **`HFS+`**.
    - **B3:** Tải app **`HeliPort`** tại [đây](https://github.com/OpenIntelWireless/HeliPort/releases/tag/v1.0.0) về máy window, copy vào usb.
    - **B4:** Cắm usb vào lại máy đang hackintosh và tiến hành cài đặt app **`HeliPort`**.
- Một số lỗi thường gặp khi không connect được wifi:
    - **Lỗi sai mật khẩu**: hãy cố gắng đảm bảo bạn đã nhập đúng mật khẩu.

### 2. Audio: (Headphone)
**Lỗi méo âm, mất âm thanh sau khi sleep, cắm lại tai nghe thì mất âm thanh**.

**- Cách Fix:**
- **B1:** Hãy đảm bảo đang để **layout** của **AppleALC** là **14**.
- **B2:** Tiến hành tải **`ALCPlugfix`** của [**`hieplpvip`**](https://github.com/hieplpvip) tại [đây](https://github.com/hieplpvip/ALC295PlugFix)
- **B3:** Cài đặt **`ALCPlugfix`** theo hướng dẫn của [**`hieplpvip`**](https://github.com/hieplpvip).
- **B4:** Tải kext **`Codeccomander`** tại [đây](https://bitbucket.org/RehabMan/os-x-eapd-codec-commander/downloads/) và bỏ vào **`LE (Library/Extensions)`**.
- **B5:** Restart lại máy.
    
**- Các lỗi hay gặp:**

**a. Báo lỗi không thể copy file vào trong usr/bin.**

**`Lúc này bạn cần tiến hành copy file thủ công. Bạn có thể mở file install.sh để xem code bên trong.`**

- **B1:** Mở terminal, nhập lệnh: **`sudo mount -uw /`** và **`sudo killall Finder`**
    (2 lệnh này mục đích để cho phép bạn copy file vào **`usr/bin`**).
- **B2:** Mở thư mục **`alc_fix`** trong thư mục tải về của [**`hieplpvip`**](https://github.com/hieplpvip), copy 2 file **`ALCPlugfix`** và **`hda_verb`** vào **`usr/bin`**.
- **B3:** Copy file **`good.win.ALCPlugFix.plist`** vào **`Library/LaunchAgents`**.
- **B4:** Chạy lại file **install.sh** của [**`hieplpvip`**](https://github.com/hieplpvip).
- **B5:** Restart lại máy.

**Lưu ý:** nếu bạn không thấy thư mục  **`usr`** thì hãy nhấn tổ hợp phím **`Command + Shift + "."`**.

**b. Nếu âm thanh vẫn chưa được fix:**

- **B1:** Tiến hành tải **`XCode`**
- **B2:** Mở project **`ALCPlugFix.xcodeproj`**
- **B3:** Chạy project.
(Khi chạy project xong, bạn có thể rút/cắm thử tai nghe vài lần để kiểm tra ALCPlugfix có hoạt động hay không)
- **B4:** Nhấp chuột phải vào file **`ALCPlugfix`** (trong thư mục Products) bên góc trên tay trái màn hình, chọn **`Show in folder`**.
- **B5:** Copy file **`ALCPlugfix`** vừa chạy được vào **`usr/bin`**.
- **B6:** Restart lại máy.

### 3. Lỗi Full phân vùng EFI của ổ cứng:

>Thông thường sau khi erase ổ cứng trước khi cài macOS lên máy, phân vùng EFI sẽ được cấp 200MB. **Vấn đề xảy ra khi các bạn xoá 1 file hay 1 folder trong phân vùng này nó sẽ không bị xoá đi hoàn toàn mà nó vẫn còn nằm ở đâu đó**. Bạn có thể kiểm tra bằng cách check xem dung lượng còn lại của phân vùng EFI máy bạn và sau đó thử xoá đi file hay 1 folder. Điều ngạc nhiên là dung lượng khả dụng vẫn không tăng lên. **Do đó có thể trong tương lai bạn sẽ bị gặp lỗi không đủ bộ nhớ để copy file vào trong EFI nữa**.

**- Cách Fix: Format lại phân vùng EFI**

Format lại phân vùng EFI và tất nhiên nó sẽ xoá toàn bộ file hay folder đang có nên trước khi format bạn hãy nhớ lưu lại bộ EFI mà bạn đã khổ công xây dựng.

>Topic gốc trên reddit.com tại [đây](https://www.reddit.com/r/hackintosh/comments/8rjdg8/efi_partition_full/) 

- **B1:** Mở terminal
- **B2:** Nhập lệnh **`diskutil list`**
- **B3:** Nhập lệnh **`sudo newfs_msdos -v EFI /dev/diskXsX`**
(**`diskXsX`** là **`IDENTIFIER`** của **`EFI`**)