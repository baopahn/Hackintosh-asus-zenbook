# Hackintosh Asus Zenbook UX430

## Lời mở đầu:
![](/Screenshots/03.png)

- Đây không phải là hướng dẫn cài hackintosh lên laptop.
- Mình chỉ cung cấp bộ EFI và chia sẻ một vài kinh nghiệm fix lỗi để hỗ trợ bạn hoàn thiện hackintosh của mình. Giúp bạn có thể có được một thiết bị gần giống với realmac nhất.
- Để hiểu rõ hơn về việc cài hackintosh các bạn có thể đọc thêm bài viết [**`quy trình cài đặt hackintosh cho người mới`**](https://vnohackintosh.com/blog/2019/11/12/quy-trinh-cai-dat-hackintosh/) của [vnohackintosh.com](https://vnohackintosh.com) hoặc đọc loạt bài [**`Hackintosh Vietnam Ebook`**](https://hackintosh.vn/hackintosh-guide) của [hackintosh.vn](https://hackintosh.vn).
- Khi bạn đã cài đặt và làm theo thành công, đừng ngần ngại chia sẻ kiến thức của mình cho những bạn khác tại các kênh hackintosh của Việt Nam.

## Cộng đồng, website hướng dẫn hackintosh của Việt Nam:

- Cộng đồng [hackintosh VNO](https://www.facebook.com/groups/vnohackintosh/?epa=SEARCH_BOX) trên Facebook.
- Trang web [vnohackintosh.com](https://vnohackintosh.com).
- Trang web [hackintosh.vn](https://hackintosh.vn).

## Nguồn gốc các bộ EFI:

- Bộ **EFI Opencore** gốc là của [tunglamvghy](https://github.com/tunglamvghy) giành cho máy **AsusS530UN** (Link gốc tại [đây](https://github.com/tunglamvghy/AsusS530UN-hackintosh)).
- Bộ **EFI Clover** mình được cung cấp bởi [thanhnhan311201](https://github.com/thanhnhan311201) (Link gốc tại [đây](https://github.com/thanhnhan311201/Hackintosh-Asus-UX430UA)).

## Cấu hình máy:

|   Thuộc tính  |       Thông số      |
|:-------------:|---------------------|
|      CPU      | Intel core I5-7200U |
|      GPU      | Intel graphics 620  |
|      RAM      | 4GB                 |
|      Wifi     | Intel AC8260        |
|      Audio    | Realtek ALC295      |

## Phiên bản macOS tương thích tốt ở thời điểm hiện tại:

![](/Screenshots/01.png)

- **MacOS 10.15.7 Catalina** (Cả 2 bộ EFI).
- **MacOS Big Sur beta 9** (EFI Opencore).
- **Lưu ý:**
    - **Đối với các máy sử dụng card wifi broadcom thì hiện tại đang bị lỗi treo táo, các máy sử dụng card wifi intel thì có thể sử dụng bộ EFI OC để nâng cấp lên Big Sur.**
    - **Nên cập nhật lại các kext nếu bạn tìm thấy repo này đã quá cũ. (Thời điểm hiện tại: `08/10/2020`)**

## Một số lưu ý trước khi dùng bộ EFI:
#### **Quan trọng:**
- Khuyến khích nên sử dụng bộ **EFI Opencore** vì nó ổn định hơn so với bộ **EFI Clover**. Bộ quản lý năng lượng của **EFI Clover** hoạt động không ổn định sau khi **Sleep/Wakeup** khiến cho nhiệt độ của CPU tăng cao mặc dù không thực hiện bất cứ tác vụ nào.
- Các kext và guide hướng dẫn hiện tại và về sau dành cho Opencore mới hơn và được cộng đồng hỗ trợ nhiều hơn.
> **Cập nhật:** Hiện tại mình sẽ chỉ **duy trì update** bộ **EFI Opencore**.

#### **Các lỗi cần phải fix khi dùng bộ EFI:**
- Tất cả phần cứng máy đều nhận chỉ trừ vân tay.
- Lỗi wifi, đối với các thiết bị sử dụng **card wifi intel** hiện tại chưa thể dùng **airport menu** gốc của máy để kết nối wifi mà phải sử dụng thêm 1 app có thên **Heliport** để kết nối wifi. (Hướng dẫn fix ở bên [dưới](#1-wifi)).
- Lỗi âm thanh bị méo, mất tiếng khi dùng tai nghe (Hướng dẫn fix ở bên [dưới](#2-audio-headphone)).
- Lỗi Hibernate (Hướng dẫn fix ở bên [dưới](#1-wifi#4-lỗi-hibernate)).
 > **Cập nhật:** Riêng đối với **EFI Opencore** hiện tại **kext wifi** đã được thay đổi sang dùng **AirportItlwm** nên đã có thể sử dụng được **airport menu** của macOS để sử dụng, không cần sử dụng **Heliport** để connect.

#### **Cấu hình bộ EFI:**
- Bộ EFI chưa có **`serial number`** và các thông tin fake thiết bị realmac. Bạn cần phải tải thêm **`GenSMBIOS`** để generate ra thông tin fake và thêm vào trong file **`config.plist`** (download tại [đây](https://github.com/corpnewt/GenSMBIOS)). Việc Fake thông tin máy này sẽ giúp các bạn có thể kích hoạt được **iMess** và **FaceTime**. 
- Đối với các bạn đã cài thành công và muốn sử dụng bộ EFI này nếu **không đủ vùng nhớ để copy/paste** thì hãy format lại phân vùng EFI (Hướng dẫn bên [dưới](#3-lỗi-full-phân-vùng-efi-của-ổ-cứng)).

## Một vài công cụ cần để hỗ trợ hoàn thiện hackintosh:
- Hackintool - download tại [đây](https://www.tonymacx86.com/threads/release-hackintool-v3-x-x.254559/).
- Clover Configurator - download tại [đây](https://mackie100projects.altervista.org/download-clover-configurator/).

## Fix một số lỗi quan trọng:
### 1. Wifi:
- Các bạn có thể tìm hiểu rõ hơn ở bài viết của bạn **`Toan Vu`** trên cộng đồng **`VNO hackintosh`** tại [đây](https://www.facebook.com/groups/vnohackintosh/permalink/3258675994179296/) (Lưu ý là phải vào nhóm thì mới xem được bài viết vì nhóm đang để chế độ **nhóm riêng tư**).
- Có 2 cách để có thể sử dụng được **kext itlwm**: sử dụng app **Heliport** để làm client kết nối wifi hoặc có thể chỉnh sửa trực tiếp **file info.plist** trong **kext itlwm** để kết nối wifi. Theo cá nhân mình khuyên các bạn nên sử dụng **Heliport** để có thể kết nối wifi tốt hơn khi di chuyển nhiều.
- Các bạn có thể sử dụng mạng LAN để tải app Heliport. Nếu các bạn không có cổng chuyển đổi từ USB -> mạng LAN thì có thể sử dụng điện thoại, kết nối với laptop bằng cáp sạc rồi chia sẻ điểm truy cập internet thông qua cổng usb. (App Heliport chỉ tầm 10MB nên tải không tốn quá nhiều dung lượng).
- Nhưng nếu các bạn không có mạng LAN và không muốn tốn tiền đăng ký mạng thì có thể làm theo cách mình hướng dẫn sau đây, cũng chính là cách kết nối wifi bằng **info.plist** trong **itlwm.kext**:
    - **B1:** Mount bộ EFI ra bên ngoài, vào nơi chứa **`itlwm.kext`**. (**`Clover/Kexts/Other`** nếu là **Clover** và **`OC/Kexts`** nếu là **Opencore**).
    - **B2:** Nhấp chuột phải vào **`itlwm.kext`** chọn **`Show Package Contents`**.
    - **B3:** Vào bên trong **Contents**, mở file **`info.plistt`** bằng **Text Edit**.
    - **B4:** Tìm **`WifiConfig`**, như ảnh phía bên dưới. Các nhánh **Wifi_1, Wifi_2, Wifi_3, Wifi_4** là các thông tin để connect wifi, các bạn hoàn toàn có thể thêm vào **Wifi_5, Wifi_6,...** với cấu trúc tương tự như **Wifi_1, Wifi_2,...** 
    - **B5:** Điền **tên wifi** và **password** như hướng dẫn bên trong hình. (Chỉ cần đổi 1 nhánh là đủ)
    ![](/Screenshots/wifi.png)
    - **B6:** Lưu và khởi động lại máy.
- Link tải app Heliport tại [đây](https://github.com/OpenIntelWireless/HeliPort/releases)

- **Một số lỗi thường gặp khi không connect được wifi:**
    - **Lỗi sai mật khẩu**: hãy cố gắng đảm bảo bạn đã nhập đúng mật khẩu. Đa số các bạn không connect được đều do nhập sai mật khẩu.
    - **Cách xoá mật khẩu cũ:** **`Click chuột vào biểu tượng wifi của app HeliPort`** -> **`Open Network Preferences`** -> **`Network`** -> **`Xoá mật khẩu wifi đã lưu`** -> **`Restart lại máy`**.

### 2. Audio (Headphone):
>**Lỗi méo âm, mất âm thanh sau khi sleep, cắm lại tai nghe thì mất âm thanh**.

**- Cách Fix:**
- **B1:** Hãy đảm bảo đang để **`layout`** của **`AppleALC`** là **14** (Dùng **hackintool** để kiểm tra).
- **B2:** Tải thư mục **`Audio`** ở phía trên.
- **B3:** Mở thư mục **`Resource`** trong **`Audio`**, copy 2 file **`ALCPlugfix`** và **`hda_verb`** vào **`/usr/local/bin`**.
- **B4:** Copy file **`good.win.ALCPlugFix.plist`** vào **`/Library/LaunchDaemons`**.
- **B5:** Chạy file **`Install.sh`** trong thư mục **`Script`**.
- **B6:** Chạy file **`Check_ALCPlugFix.sh`** để check xem **`ALCPlugFix`** đã được load hay chưa.
- **B7:** Tải kext **`Codeccommander`** tại [đây](https://bitbucket.org/RehabMan/os-x-eapd-codec-commander/downloads/) và bỏ vào **`LE (/Library/Extensions)`**.
- **B8:** Mở **`Terminal`** nhập lệnh **`sudo kextcache -i /`** để rebuild kext cache.
- **B9:** Restart lại máy.
- **B10:** Tận hưởng thành quả.

**Lưu ý:** nếu bạn không thấy thư mục  **`/usr`** thì hãy nhấn tổ hợp phím **`Command + Shift + "."`**.

**- Các lỗi hay gặp:**
> **`Codeccommander`** không load được. (Dùng **`hackintool`** để kiểm tra xem kext **`Codeccommander`** đã được load chưa).
- **B1:** Xoá **`Codeccommander`** trong **`LE`**.
- **B2:** Bỏ **`Codeccommander`** vào trong bộ EFI.
    - Clover: Bỏ **`Codeccommander`** vào trong **`/Clover/Kexts/Other`**.
    - Opencore: Bỏ **`Codeccommander`** vào trong **`/OC/Kexts`**.
- **B3:**
    - Clover chuyển sang **B4**.
    - Opencore cần chỉnh sửa file **`config.plist`** để nạp kext. Mình đã chuẩn bị sẵn, bạn chỉ cần mở file **`config.plist`**, tìm kiếm **`Codeccommander`**, tìm nhánh **`Enable`** và sửa lại thành **`true`** (mặc định là mình để là **`false`**).
- **B4:** Restart lại máy.
- **B5:** Tận hưởng thành quả.


### 3. Lỗi Full phân vùng EFI của ổ cứng:
- **Ảnh minh hoạ**

![](/Screenshots/02.png)


>Thông thường phân vùng EFI sẽ có dung lượng khoảng 200MB. **Vấn đề xảy ra khi các bạn xoá 1 file hay 1 folder trong phân vùng này, nó sẽ không bị xoá đi mà nó vẫn còn nằm ở đâu đó**. Bạn có thể kiểm tra bằng cách check xem dung lượng còn lại của phân vùng EFI máy bạn và sau đó thử xoá đi file hay 1 folder. Điều ngạc nhiên là dung lượng khả dụng vẫn không tăng lên. **Do đó có thể trong tương lai, bạn sẽ bị gặp lỗi không đủ bộ nhớ để copy file vào trong EFI nữa và gặp lỗi giống như hình minh hoạ**.

**- Cách Fix: Format lại phân vùng EFI**

>Format lại phân vùng EFI và tất nhiên nó sẽ xoá toàn bộ file hay folder đang có nên trước khi format bạn hãy nhớ **lưu lại bộ EFI** mà bạn đã khổ công xây dựng.

Topic gốc trên reddit.com tại [đây](https://www.reddit.com/r/hackintosh/comments/8rjdg8/efi_partition_full/).

- **B1:** Mở terminal.
- **B2:** Nhập lệnh **`diskutil list`**.
- **B3:** Nhập lệnh **`sudo newfs_msdos -v EFI /dev/diskXsX`** với
(**`diskXsX`** là **`IDENTIFIER`** của **`EFI`**).

### 4. Lỗi hibernate:
- Thông thường các máy hackintosh sẽ không được hỗ trợ tính năng hibernate như trên các máy realmac. Chúng ta chỉ có thể sử dụng tính năng sleep. Do đó một vài máy hackintosh sleep lâu, máy tự đưa vào chế độ hibernate do đó gây ra lỗi.
- Cách tắt hibernate:
    Dùng **`hackintool`**, vào phần **`Power`** các bạn sẽ thấy một vài dòng đỏ, chọn **`fix sleepimage`** (icon biểu tượng tua-vít) để **`hackintool`** tự fix.

### 5. Bỏ qua màn hình menu boot: 
Khi đã hoàn thành xong và bạn muốn laptop của bạn mở máy trông thật giống với macbook thật, bỏ qua màn hình boot của Clover hay Opencore, hãy làm theo hướng dẫn dưới đây.

- **Clover**: cài đặt **`timeout`** về **`0`**.
- **Opencoer**: cài đặt **`showpicker`** về **`false`**