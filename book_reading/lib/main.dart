// ============================================================
// BOOK READER APP - Flutter Demo
// Chức năng chính:
// 1. Hiển thị thư viện sách
// 2. Xem chi tiết sách
// 3. Xem mục lục
// 4. Đọc từng chương
// 5. Lưu chương đang đọc gần nhất
// 6. Thêm/xóa bookmark
// ============================================================

// Import thư viện Material Design của Flutter để dùng các widget như Scaffold, AppBar, ListView, Button, Icon...
import 'package:flutter/material.dart';

void main() {
  // runApp() đưa widget gốc BookReaderApp lên màn hình.
  runApp(const BookReaderApp());
}

// Widget gốc của toàn bộ app.
// Dùng StatelessWidget vì phần cấu hình app/theme không thay đổi trong lúc chạy.
class BookReaderApp extends StatelessWidget {
  const BookReaderApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp là khung chính của app Flutter theo Material Design.
    return MaterialApp(
      title: 'Book Reader',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xff4F63D7),
        scaffoldBackgroundColor: const Color(0xffF4F6FB),
        fontFamily: 'Arial',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff4F63D7),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      // MainScreen là màn hình đầu tiên sau khi mở app.
      home: const MainScreen(),
    );
  }
}

// Model Book
class Book {
  final int id;
  final String title;
  final String author;
  final String description;
  final List<Chapter> chapters;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.chapters,
  });
}

// Model Chapter
class Chapter {
  final int id;
  final String title;
  final String content;

  Chapter({
    required this.id,
    required this.title,
    required this.content,
  });
}

// Model BookMark
class BookMark {
  final Book book;
  final Chapter chapter;
  final DateTime createdAt;

  BookMark({
    required this.book,
    required this.chapter,
    required this.createdAt,
  });
}

// Dữ liệu mẫu của app.
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
            'Tư duy là nền tảng của mọi hành động. Khi chúng ta biết cách suy nghĩ rõ ràng, việc học tập và làm việc sẽ trở nên hiệu quả hơn.\n\nMột người có tư duy tốt không chỉ biết tìm câu trả lời, mà còn biết đặt câu hỏi đúng. Câu hỏi đúng giúp ta nhìn vấn đề sâu hơn và tránh giải quyết sai trọng tâm.',
      ),
      Chapter(
        id: 102,
        title: 'Chương 2: Quản lý thời gian',
        content:
            'Thời gian là nguồn lực công bằng nhất, ai cũng có 24 giờ mỗi ngày. Sự khác biệt nằm ở cách mỗi người sử dụng khoảng thời gian đó.\n\nQuản lý thời gian không có nghĩa là làm thật nhiều việc cùng lúc. Điều quan trọng là biết ưu tiên việc quan trọng và loại bỏ việc gây xao nhãng.',
      ),
      Chapter(
        id: 103,
        title: 'Chương 3: Hành động nhỏ mỗi ngày',
        content:
            'Thành công không đến từ một hành động lớn duy nhất, mà đến từ những hành động nhỏ được lặp lại đều đặn.\n\nMỗi ngày đọc vài trang sách, học một khái niệm mới hoặc hoàn thành một bài tập nhỏ đều góp phần tạo ra sự thay đổi lớn theo thời gian.',
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
            'Lập trình là quá trình viết hướng dẫn cho máy tính thực hiện một nhiệm vụ cụ thể.\n\nMáy tính không tự hiểu mong muốn của con người. Vì vậy, lập trình viên cần sử dụng ngôn ngữ lập trình để mô tả các bước xử lý một cách rõ ràng.',
      ),
      Chapter(
        id: 202,
        title: 'Chương 2: Biến và kiểu dữ liệu',
        content:
            'Biến là nơi lưu trữ dữ liệu trong chương trình. Ví dụ, ta có thể lưu tên người dùng, tuổi, điểm số hoặc giá sản phẩm vào biến.\n\nKiểu dữ liệu cho biết dữ liệu đó thuộc loại nào, chẳng hạn như số nguyên, số thực, chuỗi ký tự hoặc giá trị đúng sai.',
      ),
      Chapter(
        id: 203,
        title: 'Chương 3: Vòng lặp',
        content:
            'Vòng lặp giúp chương trình thực hiện một công việc nhiều lần mà không cần viết lại mã lệnh.\n\nVí dụ, nếu muốn in ra các số từ 1 đến 100, ta không cần viết 100 dòng lệnh. Thay vào đó, ta dùng vòng lặp.',
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
            'Học chủ động là khi người học không chỉ nghe hoặc đọc, mà còn đặt câu hỏi, ghi chú, thảo luận và tự kiểm tra kiến thức.\n\nKhi học chủ động, não bộ xử lý thông tin sâu hơn, từ đó giúp ghi nhớ lâu hơn.',
      ),
      Chapter(
        id: 302,
        title: 'Chương 2: Ghi chú hiệu quả',
        content:
            'Ghi chú không phải là chép lại toàn bộ nội dung. Ghi chú tốt cần ngắn gọn, có cấu trúc và thể hiện được ý chính.\n\nBạn có thể dùng sơ đồ tư duy, bảng so sánh hoặc phương pháp Cornell để ghi chú.',
      ),
      Chapter(
        id: 303,
        title: 'Chương 3: Ôn tập thông minh',
        content:
            'Ôn tập hiệu quả cần được thực hiện theo chu kỳ. Thay vì học dồn trước kỳ thi, hãy chia nhỏ nội dung và ôn lại nhiều lần.\n\nViệc ôn tập lặp lại giúp kiến thức đi vào trí nhớ dài hạn.',
      ),
    ],
  ),
];

// AppData dùng để lưu dữ liệu tạm trong bộ nhớ khi app đang chạy.
// Vì các biến là static nên màn hình nào cũng có thể truy cập chung.
// Nếu tắt app hoàn toàn thì dữ liệu này sẽ mất vì chưa lưu local database/shared preferences.
class AppData {
  // Danh sách các bookmark người dùng đã lưu.
  static List<BookMark> bookmarks = [];
  // Cuốn sách người dùng đọc gần nhất.
  static Book? lastBook;
  // Chương người dùng đọc gần nhất.
  static Chapter? lastChapter;
}

// MainScreen là màn hình chính có BottomNavigationBar gồm 3 tab.
// Dùng StatefulWidget vì selectedIndex thay đổi khi người dùng chuyển tab.
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // selectedIndex lưu tab hiện tại.
  // 0 = Thư viện, 1 = Đang đọc, 2 = Bookmark.
  int selectedIndex = 0;

  // Hàm đổi tab khi người dùng bấm vào BottomNavigationBar.
  void changeTab(int index) {
    // setState báo cho Flutter vẽ lại giao diện sau khi dữ liệu thay đổi.
    setState(() {
      selectedIndex = index;
    });
  }

  // Hàm trả về màn hình tương ứng với tab đang chọn.
  Widget getCurrentScreen() {
    if (selectedIndex == 0) {
      return const LibraryScreen();
    } else if (selectedIndex == 1) {
      return ContinueReadingScreen(
        onGoLibrary: () => changeTab(0),
      );
    } else {
      return BookmarkScreen(
        onBookmarkChanged: () {
          setState(() {});
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getCurrentScreen(),
      // Thanh điều hướng dưới cùng của app.
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: const Color(0xff4F63D7),
        unselectedItemColor: Colors.grey,
        onTap: changeTab,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Thư viện',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Đang đọc',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmark',
          ),
        ],
      ),
    );
  }
}

// Màn hình Thư viện: hiển thị danh sách tất cả sách.
class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thư viện sách'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Ô tìm kiếm sách (chỉ có giao diện, chưa có chức năng tìm kiếm thực sự)
          TextField(
            decoration: InputDecoration(
              hintText: 'Tìm kiếm sách...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Duyệt qua sampleBooks và tạo BookCard cho từng cuốn sách.
          ...sampleBooks.map((book) {
            return BookCard(book: book);
          }).toList(),
        ],
      ),
    );
  }
}

// BookCard là thẻ giao diện hiển thị thông tin tóm tắt của 1 cuốn sách.
class BookCard extends StatelessWidget {
  final Book book;

  const BookCard({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    // Kiểm tra sách này có phải là sách đang đọc gần nhất hay không.
    final bool isReading = AppData.lastBook?.id == book.id;

    return GestureDetector(
      // Khi bấm vào card sách, chuyển sang màn Chi tiết sách.
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BookDetailScreen(book: book),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 85,
              height: 120,
              decoration: BoxDecoration(
                color: const Color(0xff4F63D7),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(
                  book.title.substring(0, 1),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff26315F),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    book.author,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    book.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(height: 1.4),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isReading ? 'Đang đọc' : 'Chưa đọc',
                    style: TextStyle(
                      color: isReading ? Colors.green : Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Màn hình Chi tiết sách: hiển thị mô tả, tác giả, số chương và nút đọc.
class BookDetailScreen extends StatelessWidget {
  final Book book;

  const BookDetailScreen({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    // Lấy chương đầu tiên của sách để dùng khi người dùng chưa từng đọc sách này.
    final Chapter firstChapter = book.chapters.first;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết sách'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            height: 260,
            decoration: BoxDecoration(
              color: const Color(0xff4F63D7),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Center(
              child: Text(
                book.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            book.title,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color(0xff26315F),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tác giả: ${book.author}',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            book.description,
            style: const TextStyle(
              fontSize: 16,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Số chương: ${book.chapters.length}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          // Nút Đọc ngay: mở chương đang đọc gần nhất hoặc chương đầu tiên.
          ElevatedButton.icon(
            onPressed: () {
              // Nếu đã từng đọc cuốn này thì mở lại chương cũ, ngược lại mở chương đầu tiên.
              Chapter chapterToRead = AppData.lastBook?.id == book.id
                  ? AppData.lastChapter ?? firstChapter
                  : firstChapter;

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ReaderScreen(
                    book: book,
                    chapter: chapterToRead,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.play_arrow),
            label: const Text('Đọc ngay'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff4F63D7),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
          const SizedBox(height: 12),
          // Nút Xem mục lục: chuyển sang màn danh sách chương.
          OutlinedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TableOfContentsScreen(book: book),
                ),
              );
            },
            icon: const Icon(Icons.list),
            label: const Text('Xem mục lục'),
          ),
        ],
      ),
    );
  }
}

// Màn hình Mục lục: hiển thị danh sách các chương của một cuốn sách.
class TableOfContentsScreen extends StatelessWidget {
  final Book book;

  const TableOfContentsScreen({
    super.key,
    required this.book,
  });

  // Kiểm tra chương truyền vào đã được bookmark chưa.
  bool hasBookmark(Chapter chapter) {
    return AppData.bookmarks.any(
      (bm) => bm.book.id == book.id && bm.chapter.id == chapter.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: book.chapters.length,
        itemBuilder: (context, index) {
          // Lấy chương theo vị trí index trong danh sách chapters.
          final chapter = book.chapters[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color(0xff4F63D7),
                foregroundColor: Colors.white,
                child: Text('${index + 1}'),
              ),
              title: Text(
                chapter.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                AppData.lastChapter?.id == chapter.id
                    ? 'Đang đọc'
                    : 'Chưa đọc',
              ),
              trailing: hasBookmark(chapter)
                  ? const Icon(
                      Icons.bookmark,
                      color: Color(0xff4F63D7),
                    )
                  : const Icon(Icons.arrow_forward_ios, size: 16),
              // Bấm vào card đang đọc để mở lại đúng chương đang đọc.
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ReaderScreen(
                      book: book,
                      chapter: chapter,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// Màn hình Đọc sách.
// Dùng StatefulWidget vì chương hiện tại và trạng thái bookmark có thể thay đổi.
class ReaderScreen extends StatefulWidget {
  final Book book;
  final Chapter chapter;

  const ReaderScreen({
    super.key,
    required this.book,
    required this.chapter,
  });

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  // currentChapter lưu chương hiện tại đang được đọc.
  // late nghĩa là biến sẽ được gán giá trị sau, cụ thể trong initState().
  late Chapter currentChapter;

  @override
  void initState() {
    super.initState();
    currentChapter = widget.chapter;
    saveProgress();
  }

  // Lưu tiến độ đọc gần nhất vào AppData.
  void saveProgress() {
    AppData.lastBook = widget.book;
    AppData.lastChapter = currentChapter;
  }

  // Kiểm tra chương hiện tại có nằm trong danh sách bookmark không.
  bool isBookmarked() {
    return AppData.bookmarks.any(
      (bm) =>
          bm.book.id == widget.book.id && bm.chapter.id == currentChapter.id,
    );
  }

  // Thêm hoặc xóa bookmark khi người dùng bấm icon bookmark trên AppBar.
  void toggleBookmark() {
    setState(() {
      // Nếu đã bookmark thì xóa bookmark.
      if (isBookmarked()) {
        AppData.bookmarks.removeWhere(
          (bm) =>
              bm.book.id == widget.book.id &&
              bm.chapter.id == currentChapter.id,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đã xóa bookmark')),
        );
      } else {
        // Nếu chưa bookmark thì thêm bookmark mới vào danh sách.
        AppData.bookmarks.add(
          BookMark(
            book: widget.book,
            chapter: currentChapter,
            createdAt: DateTime.now(),
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đã thêm bookmark')),
        );
      }
    });
  }

  // Chuyển sang chương theo index mới và lưu lại tiến độ.
  void goToChapter(int newIndex) {
    setState(() {
      currentChapter = widget.book.chapters[newIndex];
      saveProgress();
    });
  }

  // Xử lý nút Chương trước.
  void previousChapter() {
    final currentIndex = widget.book.chapters.indexWhere(
      (c) => c.id == currentChapter.id,
    );

    if (currentIndex > 0) {
      goToChapter(currentIndex - 1);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đây là chương đầu tiên')),
      );
    }
  }

  // Xử lý nút Chương sau.
  void nextChapter() {
    final currentIndex = widget.book.chapters.indexWhere(
      (c) => c.id == currentChapter.id,
    );

    if (currentIndex < widget.book.chapters.length - 1) {
      goToChapter(currentIndex + 1);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đây là chương cuối cùng')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // bookmarked quyết định icon trên AppBar là bookmark đầy hay bookmark viền.
    final bool bookmarked = isBookmarked();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Đọc sách'),
        actions: [
          IconButton(
            onPressed: toggleBookmark,
            icon: Icon(
              bookmarked ? Icons.bookmark : Icons.bookmark_border,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            widget.book.title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            currentChapter.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xff26315F),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            currentChapter.content,
            style: const TextStyle(
              fontSize: 18,
              height: 1.8,
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
      // Thanh nút dưới màn đọc sách: Chương trước - Mục lục - Chương sau.
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: previousChapter,
                child: const Text('Chương trước'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TableOfContentsScreen(book: widget.book),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff4F63D7),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Mục lục'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OutlinedButton(
                onPressed: nextChapter,
                child: const Text('Chương sau'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Màn hình Đang đọc: hiển thị cuốn sách/chương đọc gần nhất.
class ContinueReadingScreen extends StatelessWidget {
  final VoidCallback onGoLibrary;

  const ContinueReadingScreen({
    super.key,
    required this.onGoLibrary,
  });

  @override
  Widget build(BuildContext context) {
    // Lấy sách và chương gần nhất từ AppData.
    final book = AppData.lastBook;
    final chapter = AppData.lastChapter;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Đang đọc'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        // Nếu chưa có tiến độ đọc thì hiển thị trạng thái rỗng.
        child: book == null || chapter == null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.menu_book,
                      size: 70,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Bạn chưa đọc sách nào',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 16),
                    // Bấm nút này để quay về tab Thư viện.
                    ElevatedButton(
                      onPressed: onGoLibrary,
                      child: const Text('Mở thư viện'),
                    ),
                  ],
                ),
              )
            : Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: const Icon(
                    Icons.menu_book,
                    size: 42,
                    color: Color(0xff4F63D7),
                  ),
                  title: Text(
                    book.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(chapter.title),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ReaderScreen(
                          book: book,
                          chapter: chapter,
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}

// Màn hình Bookmark: hiển thị danh sách các chương đã được lưu.
class BookmarkScreen extends StatelessWidget {
  final VoidCallback onBookmarkChanged;

  const BookmarkScreen({
    super.key,
    required this.onBookmarkChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Lấy danh sách bookmark từ AppData.
    final bookmarks = AppData.bookmarks;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmark của tôi'),
      ),
      // Nếu chưa có bookmark thì hiển thị thông báo rỗng.
      body: bookmarks.isEmpty
          ? const Center(
              child: Text(
                'Chưa có bookmark nào',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: bookmarks.length,
              itemBuilder: (context, index) {
                // Lấy bookmark tại vị trí index.
                final bm = bookmarks[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.bookmark,
                      color: Color(0xff4F63D7),
                    ),
                    title: Text(
                      bm.book.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${bm.chapter.title}\nĐã lưu: ${bm.createdAt.day}/${bm.createdAt.month}/${bm.createdAt.year}',
                    ),
                    isThreeLine: true,
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      // Bấm icon thùng rác để xóa bookmark khỏi danh sách.
                      onPressed: () {
                        AppData.bookmarks.removeAt(index);
                        onBookmarkChanged();

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Đã xóa bookmark')),
                        );
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ReaderScreen(
                            book: bm.book,
                            chapter: bm.chapter,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}