class StorageItem {
  final int id;
  final String title;
  final String note;

  const StorageItem({
    required this.id,
    required this.title,
    required this.note,
  });

  factory StorageItem.fromJson(Map<String, dynamic> json) {
    return StorageItem(
      id: json['id'] as int,
      title: json['title'] as String,
      note: json['note'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'note': note,
    };
  }
}
