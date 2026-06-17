import 'package:flutter_test/flutter_test.dart';
import 'package:lab10_full/features/auth/domain/login_response.dart';

void main() {
  test('LoginResponse parses DummyJSON auth response', () {
    final response = LoginResponse.fromJson({
      'username': 'emilys',
      'email': 'emily@example.com',
      'firstName': 'Emily',
      'lastName': 'Johnson',
      'accessToken': 'token-value',
    });

    expect(response.username, 'emilys');
    expect(response.email, 'emily@example.com');
    expect(response.fullName, 'Emily Johnson');
    expect(response.accessToken, 'token-value');
  });
}
