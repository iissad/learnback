import 'package:learnback/features/auth/domain/models/auth_result.dart';

abstract class AuthRepository {
  Future<AuthResult> login({required String email, required String password});

  Future<AuthResult> register({
    required String name,
    required String email,
    required String password,
  });

  Future<AuthResult> getProfile();
}
