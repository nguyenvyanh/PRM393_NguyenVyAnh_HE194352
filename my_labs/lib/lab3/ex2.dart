import 'dart:async';
import 'dart:convert';

class User {
  final String name;
  final String email;

  User({
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
    );
  }

  @override
  String toString() {
    return 'User(name: $name, email: $email)';
  }
}

class UserRepository {
  // Simulates fetching JSON data from an API.
  Future<List<User>> fetchUsers() async {
    await Future.delayed(Duration(milliseconds: 500));

    final String jsonResponse = '''
    [
      {"name": "Alice", "email": "alice@example.com"},
      {"name": "Bob", "email": "bob@example.com"},
      {"name": "Charlie", "email": "charlie@example.com"}
    ]
    ''';

    final List<dynamic> decodedJson = jsonDecode(jsonResponse);

    return decodedJson
        .map((item) => User.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}

Future<void> main() async {

  final repo = UserRepository();
  final users = await repo.fetchUsers();

  print('Fetched users:');
  for (final user in users) {
    print(user);
  }

}
