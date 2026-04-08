/// Auth domain model returned after a successful login or register.
class AuthResult {
  const AuthResult({required this.token, required this.userId});

  final String token;
  final String userId;
}
