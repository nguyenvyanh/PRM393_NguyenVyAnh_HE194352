# LAB 9 - Working With Local JSON Storage

Project này gộp đủ 3 phần của Lab 9:

## Nội dung đã làm

### Lab 9.1 - Read JSON From Assets
- Có file `assets/data/students.json`
- Đăng ký assets trong `pubspec.yaml`
- Đọc file bằng `rootBundle.loadString()`
- Parse bằng `jsonDecode`
- Hiển thị bằng `ListView.builder`
- Mỗi item hiển thị nhiều hơn 2 field: id, name, major, score

### Lab 9.2 - Save & Load JSON From Device Storage
- Dùng `path_provider`
- Đọc/ghi file JSON trong application documents directory
- Có UI thêm item
- Có nút Save
- Có nút Reload from storage để kiểm tra dữ liệu sau khi lưu
- Dữ liệu được giữ lại sau khi restart app

### Lab 9.3 - Local JSON CRUD + Search
- Có file seed: `assets/data/products_seed.json`
- Tạo local database file: `lab_9_3_products_db.json`
- Có chức năng:
  - Add product
  - Edit product
  - Delete product
  - Search product
  - Reset database
- Tự động save JSON sau mỗi thao tác CRUD


## Evidence nên chụp

1. Màn Lab 9.1 hiển thị danh sách sinh viên từ `students.json`.
2. Màn Lab 9.2:
   - Nhập item mới
   - Bấm Add item
   - Bấm Save
   - Tắt app/mở lại hoặc bấm Reload from storage để chứng minh dữ liệu vẫn còn.
3. Màn Lab 9.3:
   - Danh sách product ban đầu
   - Add product
   - Edit product
   - Delete product có confirm dialog
   - Search/filter product
   - Reset DB nếu cần
