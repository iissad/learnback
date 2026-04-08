import 'package:dio/dio.dart';
import 'package:learnback/features/auth/domain/models/auth_result.dart';
import 'package:learnback/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<AuthResult> login({
    required String email,
    required String password,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/auth/login',
      data: {'email': email, 'password': password},
    );
    final data = response.data!;
    return AuthResult(
      token: data['token'] as String,
      userId: data['userId'] as String? ?? '',
    );
  }

  @override
  Future<AuthResult> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/auth/register',
      data: {'name': name, 'email': email, 'password': password},
    );
    final data = response.data!;
    return AuthResult(
      token: data['token'] as String,
      userId: data['userId'] as String? ?? '',
    );
  }
}
