/// Auth domain model returned after a successful login or register.
class AuthResult {
  const AuthResult({
    required this.token,
    required this.userId,
    this.name = '',
    this.email = '',
    this.role = '',
  });

  final String token;
  final String userId;
  final String name;
  final String email;
  final String role;
}
