/// [LoginRequest] class digunakan untuk menampung value dari login
class LoginRequest {
  final String email;
  final String password;

  /// login request constructor
  LoginRequest(this.email, this.password);

  /// [toJson] digunakan untuk generate object Map dari [LoginRequest]
  Map<String, String> toJson() => {'email': email, 'password': password};
}
