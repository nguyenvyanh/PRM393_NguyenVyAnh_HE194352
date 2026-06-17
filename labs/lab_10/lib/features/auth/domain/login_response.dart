class LoginResponse {
  LoginResponse({
    required this.username,
    required this.email,
    required this.fullName,
    required this.accessToken,
  });

  final String username;
  final String email;
  final String fullName;
  final String accessToken;

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final firstName = json['firstName']?.toString() ?? '';
    final lastName = json['lastName']?.toString() ?? '';

    return LoginResponse(
      username: json['username']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      fullName: '$firstName $lastName'.trim(),
      accessToken: (json['accessToken'] ?? json['token'])?.toString() ?? '',
    );
  }
}
