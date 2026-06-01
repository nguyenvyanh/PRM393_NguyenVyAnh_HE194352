import '../models/book.dart';
import '../models/chapter.dart';

final List<Book> sampleBooks = [
  Book(
    id: 1,
    title: 'Tư Duy Hiệu Quả',
    author: 'Nguyễn Minh',
    description:
        'Cuốn sách giúp người đọc rèn luyện tư duy logic, quản lý thời gian và xây dựng thói quen học tập hiệu quả.',
    chapters: [
      Chapter(
        id: 101,
        title: 'Chương 1: Bắt đầu từ tư duy',
        content:
            'Tư duy là nền tảng của mọi hành động. Khi chúng ta biết cách suy nghĩ rõ ràng, việc học tập và làm việc sẽ trở nên hiệu quả hơn.\n\nMột người có tư duy tốt không chỉ biết tìm câu trả lời, mà còn biết đặt câu hỏi đúng.',
      ),
      Chapter(
        id: 102,
        title: 'Chương 2: Quản lý thời gian',
        content:
            'Thời gian là nguồn lực công bằng nhất, ai cũng có 24 giờ mỗi ngày. Sự khác biệt nằm ở cách mỗi người sử dụng khoảng thời gian đó.',
      ),
      Chapter(
        id: 103,
        title: 'Chương 3: Hành động nhỏ mỗi ngày',
        content:
            'Thành công không đến từ một hành động lớn duy nhất, mà đến từ những hành động nhỏ được lặp lại đều đặn.',
      ),
    ],
  ),
  Book(
    id: 2,
    title: 'Lập Trình Cơ Bản',
    author: 'Trần Anh',
    description:
        'Sách nhập môn lập trình, phù hợp cho người mới bắt đầu học về biến, hàm, vòng lặp và tư duy giải thuật.',
    chapters: [
      Chapter(
        id: 201,
        title: 'Chương 1: Lập trình là gì?',
        content:
            'Lập trình là quá trình viết hướng dẫn cho máy tính thực hiện một nhiệm vụ cụ thể.',
      ),
      Chapter(
        id: 202,
        title: 'Chương 2: Biến và kiểu dữ liệu',
        content:
            'Biến là nơi lưu trữ dữ liệu trong chương trình. Kiểu dữ liệu cho biết dữ liệu đó thuộc loại nào.',
      ),
      Chapter(
        id: 203,
        title: 'Chương 3: Vòng lặp',
        content:
            'Vòng lặp giúp chương trình thực hiện một công việc nhiều lần mà không cần viết lại mã lệnh.',
      ),
    ],
  ),
  Book(
    id: 3,
    title: 'Kỹ Năng Học Tập',
    author: 'Lê Hạnh',
    description:
        'Cuốn sách chia sẻ phương pháp học tập chủ động, ghi chú thông minh và ôn tập hiệu quả.',
    chapters: [
      Chapter(
        id: 301,
        title: 'Chương 1: Học chủ động',
        content:
            'Học chủ động là khi người học không chỉ nghe hoặc đọc, mà còn đặt câu hỏi, ghi chú và tự kiểm tra kiến thức.',
      ),
      Chapter(
        id: 302,
        title: 'Chương 2: Ghi chú hiệu quả',
        content:
            'Ghi chú không phải là chép lại toàn bộ nội dung. Ghi chú tốt cần ngắn gọn, có cấu trúc và thể hiện được ý chính.',
      ),
      Chapter(
        id: 303,
        title: 'Chương 3: Ôn tập thông minh',
        content:
            'Ôn tập hiệu quả cần được thực hiện theo chu kỳ. Việc ôn tập lặp lại giúp kiến thức đi vào trí nhớ dài hạn.',
      ),
    ],
  ),
];