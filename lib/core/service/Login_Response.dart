class LoginResponse {
  final int id; // userId yerine id

  LoginResponse({required this.id});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      id: json['id'], // userId yerine id
    );
  }
}
