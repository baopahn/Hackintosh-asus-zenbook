# Hackintosh Asus Zenbook UX430

## Lời mở đầu:

![](/Screenshots/03.png)

- Để hiểu rõ hơn về việc cài hackintosh các bạn có thể đọc thêm bài viết [**`quy trình cài đặt hackintosh cho người mới`**](https://vnohackintosh.com/blog/2019/11/12/quy-trinh-cai-dat-hackintosh/) của [vnohackintosh.com](https://vnohackintosh.com) hoặc đọc loạt bài [**`Hackintosh Vietnam Ebook`**](https://hackintosh.vn/hackintosh-guide) của [hackintosh.vn](https://hackintosh.vn).
- Khi bạn đã cài đặt và làm theo thành công, đừng ngần ngại chia sẻ kiến thức của mình cho những bạn khác tại các kênh hackintosh của Việt Nam.

## Cộng đồng, website hướng dẫn hackintosh của Việt Nam:

- Cộng đồng [hackintosh VNO](https://www.facebook.com/groups/vnohackintosh/?epa=SEARCH_BOX) trên Facebook.
- Trang web [vnohackintosh.com](https://vnohackintosh.com).
- Trang web [hackintosh.vn](https://hackintosh.vn).

## Nguồn gốc của tool:

- Tool này được xây dựng dựa trên tool tạo bộ EFI của [hieplvip](https://github.com/hieplpvip) trong project [Asus-Zenbook-Hackintosh](https://github.com/hieplpvip/Asus-Zenbook-Hackintosh). Các bạn hãy ghé thăm và donate cho bạn ấy tại đây [![Donate with PayPal](https://img.shields.io/badge/paypal-donate-red.svg)](https://paypal.me/lebhiep).
- Với mong muốn giúp các bạn có thêm giải pháp đơn giản hơn để tiếp cận với hackintosh mà không tốn quá nhiều thời gian. Mình đã tổng hợp lại những vấn đề còn thiếu trong Tool của bạn [hieplvip](https://github.com/hieplpvip) như kext wifi/bluetooth intel, tự động sinh thông tin như serial number, uuid, mlb. Các bạn chỉ việc Plug & Play.

## Các máy được hỗ trợ:

- UX310 (Kaby Lake)
- UX330 (Kaby Lake)
- UX330 (Kaby Lake-R)
- UX410 (Kaby Lake)
- UX430 (Kaby Lake)
- UX430 (Kaby Lake-R)

## Một vài công cụ cần để hỗ trợ hoàn thiện hackintosh:

- Hackintool - download tại [đây](https://www.tonymacx86.com/threads/release-hackintool-v3-x-x.254559/).
- Clover Configurator - download tại [đây](https://mackie100projects.altervista.org/download-clover-configurator/).

## Hướng dẫn sử dụng:

### Một số yêu cầu:

- Các bạn cần sử dụng hệ điều hành macOS để tối ưu nhất việc tạo EFI, nếu các bạn không có macOS thì hãy dùng máy ảo để tạo bộ cài nhé.

### Hướng dẫn tạo bộ EFI:

#### Bước 1: Mở terminal và chạy dòng lệnh bên dưới để download tool về máy:

```shell
git clone https://github.com/PLHB1712289/Hackintosh-asus-zenbook.git zenbook
cd zenbook
```

#### Bước 2: Gõ lệnh để bật tool:

```shell
sh main.sh
```

#### Bước 3: Chọn option số 1 để build EFI:

- Sau khi tạo xong bộ EFI sẽ nằm trong `/ToolCreateEFI/build`

### Hướng dẫn fix lỗi âm thanh trên tai nghe:

- Các bạn tiếp tục mở tool của mình và chọn option số 2 thì âm thanh sẽ tự động được fix. Rất đơn giản :)))

## Một số lỗi thường gặp:

### 1. Lỗi Full phân vùng EFI của ổ cứng:

- **Ảnh minh hoạ**

![](/Screenshots/02.png)

> Thông thường phân vùng EFI sẽ có dung lượng khoảng 200MB. **Vấn đề xảy ra khi các bạn xoá 1 file hay 1 folder trong phân vùng này, nó sẽ không bị xoá đi mà nó vẫn còn nằm ở đâu đó**. Bạn có thể kiểm tra bằng cách check xem dung lượng còn lại của phân vùng EFI máy bạn và sau đó thử xoá đi file hay 1 folder. Điều ngạc nhiên là dung lượng khả dụng vẫn không tăng lên. **Do đó có thể trong tương lai, bạn sẽ bị gặp lỗi không đủ bộ nhớ để copy file vào trong EFI nữa và gặp lỗi giống như hình minh hoạ**.

**- Cách Fix: Format lại phân vùng EFI**

> Format lại phân vùng EFI và tất nhiên nó sẽ xoá toàn bộ file hay folder đang có nên trước khi format bạn hãy nhớ **lưu lại bộ EFI** mà bạn đã khổ công xây dựng.

Topic gốc trên reddit.com tại [đây](https://www.reddit.com/r/hackintosh/comments/8rjdg8/efi_partition_full/).

- **B1:** Mở terminal.
- **B2:** Nhập lệnh **`diskutil list`**.
- **B3:** Nhập lệnh **`sudo newfs_msdos -v EFI /dev/diskXsX`** với
  (**`diskXsX`** là **`IDENTIFIER`** của **`EFI`**).

### 2. Bỏ qua màn hình menu boot:

Khi đã hoàn thành xong và bạn muốn laptop của bạn mở máy trông thật giống với macbook thật, bỏ qua màn hình boot của Clover hay Opencore, hãy làm theo hướng dẫn dưới đây.

- **Clover**: cài đặt **`timeout`** về **`0`**.
- **Opencoer**: cài đặt **`showpicker`** về **`false`**
