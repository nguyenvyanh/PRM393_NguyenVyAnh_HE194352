import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/post.dart';

class ApiService {
  ApiService({http.Client? client}) : _client = client ?? http.Client();

  static const String _baseUrl =
      'https://jsonplaceholder.typicode.com';

  final http.Client _client;

  Future<List<Post>> fetchPosts() async {
    final uri = Uri.parse('$_baseUrl/posts');

    try {
      final response = await _client
          .get(
            uri,
            headers: const {'Accept': 'application/json'},
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode != 200) {
        throw ApiException(
          'Máy chủ trả về lỗi ${response.statusCode}.',
        );
      }

      final dynamic decoded =
          json.decode(utf8.decode(response.bodyBytes));

      if (decoded is! List) {
        throw const FormatException(
          'Dữ liệu nhận được không phải là một danh sách.',
        );
      }

      return decoded
          .map(
            (item) => Post.fromJson(
              Map<String, dynamic>.from(item as Map),
            ),
          )
          .toList();
    } on TimeoutException {
      throw ApiException(
        'Kết nối quá thời gian. Hãy kiểm tra mạng và thử lại.',
      );
    } on http.ClientException {
      throw ApiException(
        'Không thể kết nối tới máy chủ. Hãy kiểm tra Internet.',
      );
    } on FormatException catch (error) {
      throw ApiException('Dữ liệu JSON không hợp lệ: ${error.message}');
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException('Đã xảy ra lỗi: $error');
    }
  }

  Future<Post> createPost({
    required String title,
    required String body,
  }) async {
    final uri = Uri.parse('$_baseUrl/posts');

    try {
      final response = await _client
          .post(
            uri,
            headers: const {
              'Content-Type': 'application/json; charset=UTF-8',
              'Accept': 'application/json',
            },
            body: json.encode({
              'title': title,
              'body': body,
              'userId': 1,
            }),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode != 201) {
        throw ApiException(
          'Tạo bài viết thất bại. Mã lỗi: ${response.statusCode}.',
        );
      }

      final dynamic decoded =
          json.decode(utf8.decode(response.bodyBytes));

      if (decoded is! Map) {
        throw const FormatException(
          'Dữ liệu trả về không đúng định dạng.',
        );
      }

      return Post.fromJson(Map<String, dynamic>.from(decoded));
    } on TimeoutException {
      throw ApiException(
        'Kết nối quá thời gian. Hãy thử gửi lại.',
      );
    } on http.ClientException {
      throw ApiException(
        'Không thể kết nối tới máy chủ.',
      );
    } on FormatException catch (error) {
      throw ApiException('Dữ liệu JSON không hợp lệ: ${error.message}');
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException('Không thể tạo bài viết: $error');
    }
  }

  void dispose() {
    _client.close();
  }
}

class ApiException implements Exception {
  const ApiException(this.message);

  final String message;

  @override
  String toString() => message;
}
