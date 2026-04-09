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

    final responseBody = response.data!;
    final dynamic data = responseBody['data'];

    if (data is Map<String, dynamic>) {
      return AuthResult(
        token: data['token'] as String? ?? '',
        userId: (data['_id'] ?? data['userId'] ?? '') as String,
        name: data['name'] as String? ?? '',
        email: data['email'] as String? ?? '',
        role: data['role'] as String? ?? '',
      );
    }

    return const AuthResult(token: '', userId: '');
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

    final responseBody = response.data!;

    if (responseBody['success'] == true) {
      // The current UI (RegisterScreen) listens for AuthStatus.registered
      // and redirects to /confirm-email. Returning this result triggers that flow.
      return const AuthResult(token: '', userId: '');
    }

    throw DioException(
      requestOptions: response.requestOptions,
      response: response,
      message:
          responseBody['message'] ??
          responseBody['error'] ??
          'Registration failed',
    );
  }
}
