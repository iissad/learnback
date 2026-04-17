import 'dart:developer' as dev;
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DioClient {
  final Dio _dio;
  final FlutterSecureStorage _secureStorage;

  DioClient({Dio? dioOverride, FlutterSecureStorage? secureStorage})
    : _dio =
          dioOverride ??
          Dio(
            BaseOptions(
              baseUrl: dotenv.env['API_BASE_URL']!,
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
              headers: {'Content-Type': 'application/json'},
            ),
          ),
      _secureStorage = secureStorage ?? const FlutterSecureStorage() {
    _initInterceptors();
  }

  void _initInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Attach JWT token if available
          final token = await _secureStorage.read(key: 'jwt_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          // TODO: centralized error handling, navigation on 401
          return handler.next(e);
        },
      ),
    );
    // Custom logging interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final isPost = options.method.toUpperCase() == 'POST';
          final auth = options.headers['Authorization'];
          final buffer = StringBuffer()
            ..writeln('┌── REQUEST ─────────────────────────')
            ..writeln('│ ${options.method}  ${options.uri}');
          if (isPost && options.data != null) {
            buffer.writeln('│ Body: ${options.data}');
          }
          if (auth != null) {
            buffer.writeln('│ Auth: $auth');
          }
          buffer.write('└────────────────────────────────────');
          dev.log(buffer.toString(), name: 'DioClient');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          final buffer = StringBuffer()
            ..writeln('┌── RESPONSE ────────────────────────')
            ..writeln('│ Status: ${response.statusCode}')
            ..writeln('│ Body:   ${response.data}')
            ..write('└────────────────────────────────────');
          dev.log(buffer.toString(), name: 'DioClient');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          final buffer = StringBuffer()
            ..writeln('┌── ERROR ───────────────────────────')
            ..writeln('│ Status: ${e.response?.statusCode}')
            ..writeln('│ Body:   ${e.response?.data}')
            ..writeln('│ Error:  ${e.message}')
            ..write('└────────────────────────────────────');
          dev.log(buffer.toString(), name: 'DioClient', error: e);
          return handler.next(e);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
