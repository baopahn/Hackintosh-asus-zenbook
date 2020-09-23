# Hackintosh-asus-zenbook-ux430

## Lời mở đầu:
- Mình chỉ cung cấp bộ EFI của mình và chia sẻ một vài kinh nghiệm fix lỗi của mình.
- Đây không phải là hướng dẫn cài hackintosh lên laptop. Các bạn có thể tự tìm hiểu bằng cách đọc thêm tại [vnohackintosh.com](https://vnohackintosh.com) hoặc [hackintosh.vn](https://hackintosh.vn).
- Để hiểu rõ hơn về việc cài hackintosh các bạn có thể đọc thêm bài viết [**`quy trình cài đặt hackintosh cho người mới`**](https://vnohackintosh.com/blog/2019/11/12/quy-trinh-cai-dat-hackintosh/) của [vnohackintosh.com](https://vnohackintosh.com) hoặc đọc loạt bài [**`Hackintosh Vietnam Ebook`**](https://hackintosh.vn/hackintosh-guide) của [hackintosh.vn](https://hackintosh.vn)
- Khi bạn đã cài đặt và làm theo thành công, đừng ngần ngại chia sẻ kiến thức của mình cho những bạn khác tại các kênh hackintosh của Việt Nam.

## Cộng đồng, website hướng dẫn hackintosh của Việt Nam:
- Cộng đồng [hackintosh VNO](https://www.facebook.com/groups/vnohackintosh/?epa=SEARCH_BOX) trên Facebook.
- Trang web [vnohackintosh.com](https://vnohackintosh.com).
- Trang web [hackintosh.vn](https://hackintosh.vn).

## Cấu hình máy:

|   Thuộc tính  |       Thông số      |
|:-------------:|---------------------|
|      CPU      | Intel core I5-7200U |
|      GPU      | Intel graphics 620  |
|      RAM      | 4GB                 |
|      Wifi     | Intel AC8260        |
|      Audio    | Realtek ALC295      |

## Phiên bản macOS tương thích tốt ở thời điểm hiện tại:

- **MacOS 10.15.6 Catalina**
- **Lưu ý: Nên cập nhật lại các kext nếu bạn tìm thấy repos này đã quá cũ. (Thời điểm hiện tại: `10/09/2020`)**

## Một số lưu ý trước khi cài macOS:
- Hầu hết máy đều nhận chỉ trừ vân tay.
- Lỗi âm thanh bị méo, mất tiếng khi dùng tai nghe (Đã có hướng dẫn fix ở bên dưới).
- Bộ EFI chưa có **`serial number`** và các thông tin Fake các thiết bị mac. Bạn cần phải tải thêm **`GenSMBIOS`** để generate ra thông tin fake và thêm vào trong file **`config.plist`** (download tại [đây](https://github.com/corpnewt/GenSMBIOS)). Việc Fake thông tin máy này sẽ giúp các bạn có thể kích hoạt được iMess và FaceTime. 

## Một vài công cụ cần để hỗ trợ hoàn thiện hackintosh:
- Hackintool - download tại [đây](https://www.tonymacx86.com/threads/release-hackintool-v3-x-x.254559/).
- Clover Configurator - download tại [đây](https://mackie100projects.altervista.org/download-clover-configurator/).

## Fix một số lỗi quan trọng:
### 1. Wifi:
- Trong bộ **`EFI`** đã cài sẵn kext để sử dụng wifi đối với những máy sử dụng card wifi của intel. Nhưng để kích hoạt được wifi thì cần phải dùng app có tên **`HeliPort`**.
- Các bạn có thể tìm hiểu rõ hơn ở bài viết của bạn **`Toan Vu`** trên cộng đồng **`VNO hackintosh`** tại [đây](https://www.facebook.com/groups/vnohackintosh/permalink/3258675994179296/) (Lưu ý là phải vào nhóm thì mới xem được bài viết vì nhóm đang để chế độ **nhóm riêng tư**).
- Đối với các bạn có thể cắm mạng LAN thì dễ dàng cài đặt app, nhưng đối với các bạn không thể xài mạng LAN thì có thể dùng giải pháp sử dụng thêm 1 laptop Window và làm như sau:
    - **B1:** Tải app **`MacDrive`** tại [đây](https://www.macdrive.com) vào máy window (App cho phép window đọc được các phân vùng định dạng của macOS).
    - **B2:** Dùng macOS (máy đang hackintosh), mở app **`Disk Utility`** rồi format lại usb theo định dạng **`HFS+`**.
    - **B3:** Tải app **`HeliPort`** tại [đây](https://github.com/OpenIntelWireless/HeliPort/releases/tag/v1.0.0) về máy window, copy vào usb.
    - **B4:** Cắm usb vào lại máy đang hackintosh và tiến hành cài đặt app **`HeliPort`**.
- Một số lỗi thường gặp khi không connect được wifi:
    - **Lỗi sai mật khẩu**: hãy cố gắng đảm bảo bạn đã nhập đúng mật khẩu. Đa số các bạn không connect được đều do nhập sai mật khẩu.
    - **Cách xoá mật khẩu cũ:** **`Click chuột vào biểu tượng wifi của app HeliPort`** -> **`Open Network Preferences`** -> **`Network`** -> **`Xoá mật khẩu wifi đã lưu`** -> **`Restart lại máy`**.

### 2. Audio (Headphone):
>**Lỗi méo âm, mất âm thanh sau khi sleep, cắm lại tai nghe thì mất âm thanh**.

**- Cách Fix:**
- **B1:** Hãy đảm bảo đang để **`layout`** của **`AppleALC`** là **14**.
- **B2:** Tiến hành tải **`ALCPlugfix`** của [**`hieplpvip`**](https://github.com/hieplpvip) tại [đây](https://github.com/hieplpvip/ALC295PlugFix).
- **B3:** Cài đặt **`ALCPlugfix`** theo hướng dẫn của [**`hieplpvip`**](https://github.com/hieplpvip).
- **B4:** Tải kext **`Codeccommander`** tại [đây](https://bitbucket.org/RehabMan/os-x-eapd-codec-commander/downloads/) và bỏ vào **`LE (/Library/Extensions)`**.
- **B5:** Restart lại máy.
    
**- Các lỗi hay gặp:**

**a. Báo lỗi không thể copy file vào trong `/usr/bin`.**

>**Lúc này bạn cần tiến hành copy file thủ công. Bạn có thể mở file install.sh xem code bên trong để hiểu rõ hơn.**

- **B1:** Mở terminal, nhập lệnh: **`sudo mount -uw /`** và **`sudo killall Finder`**.
    (2 lệnh này mục đích để cho phép bạn copy file vào **`/usr/bin`**).
- **B2:** Mở thư mục **`alc_fix`** trong thư mục tải về của [**`hieplpvip`**](https://github.com/hieplpvip), copy 2 file **`ALCPlugfix`** và **`hda_verb`** vào **`/usr/bin`**.
- **B3:** Copy file **`good.win.ALCPlugFix.plist`** vào **`/Library/LaunchAgents`**.
- **B4:** Chạy lại file **install.sh** của [**`hieplpvip`**](https://github.com/hieplpvip).
- **B5:** Restart lại máy.

**Lưu ý:** nếu bạn không thấy thư mục  **`/usr`** thì hãy nhấn tổ hợp phím **`Command + Shift + "."`**.

**b. Nếu âm thanh vẫn chưa được fix:**
>Nếu bạn đã làm tất cả các cách ở bên trên, service **`good.win.ALCPlugFix.plist`** đã load nhưng vẫn không fix được. Hãy thử cách bên dưới.

- **B1:** Tiến hành tải **`XCode`**.
- **B2:** Mở project **`ALCPlugFix.xcodeproj`**.
- **B3:** Chạy project.
(Khi chạy project xong, bạn có thể rút/cắm thử tai nghe vài lần để kiểm tra **`ALCPlugfix`** có hoạt động hay không).
- **B4:** Nhấp chuột phải vào file **`ALCPlugfix`** (trong thư mục **`Products`**) bên góc trên tay trái màn hình, chọn **`Show in folder`**.
- **B5:** Copy file **`ALCPlugfix`** vừa chạy được vào **`/usr/bin`**.
- **B6:** Restart lại máy.

### 3. Lỗi Full phân vùng EFI của ổ cứng:

>Thông thường phân vùng EFI sẽ có dung lượng khoảng 200MB. **Vấn đề xảy ra khi các bạn xoá 1 file hay 1 folder trong phân vùng này, nó sẽ không bị xoá đi mà nó vẫn còn nằm ở đâu đó**. Bạn có thể kiểm tra bằng cách check xem dung lượng còn lại của phân vùng EFI máy bạn và sau đó thử xoá đi file hay 1 folder. Điều ngạc nhiên là dung lượng khả dụng vẫn không tăng lên. **Do đó có thể trong tương lai, bạn sẽ bị gặp lỗi không đủ bộ nhớ để copy file vào trong EFI nữa**.

**- Cách Fix: Format lại phân vùng EFI**

>Format lại phân vùng EFI và tất nhiên nó sẽ xoá toàn bộ file hay folder đang có nên trước khi format bạn hãy nhớ **lưu lại bộ EFI** mà bạn đã khổ công xây dựng.

Topic gốc trên reddit.com tại [đây](https://www.reddit.com/r/hackintosh/comments/8rjdg8/efi_partition_full/).

- **B1:** Mở terminal.
- **B2:** Nhập lệnh **`diskutil list`**.
- **B3:** Nhập lệnh **`sudo newfs_msdos -v EFI /dev/diskXsX`** với
(**`diskXsX`** là **`IDENTIFIER`** của **`EFI`**).

### 4. Lỗi hibernate:
- Thông thường các máy hackintosh sẽ không được hỗ trợ tính năng hibernate như trên các máy realmac. Chúng ta chỉ có thể sử dụng tính năng sleep. Do đó một vài máy hackintosh sleep lâu, máy tự đưa vào chế độ hibernate do đó gây ra lỗi.
- Các tắt hibernate:
    Dùng **`hackintool`**, vào phần **`Power`** các bạn sẽ thấy một vài dòng đỏ, chọn **`fix sleepimage`** (icon biểu tượng tua-vít) để **`hackintool`** tự fix.

    