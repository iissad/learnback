import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:learnback/core/network/dio_client.dart';
import 'package:learnback/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:learnback/features/auth/domain/repositories/auth_repository.dart';

// ── Infrastructure providers ──────────────────────────────────────────────────

final _secureStorageProvider = Provider<FlutterSecureStorage>(
  (_) => const FlutterSecureStorage(),
);

final _dioProvider = Provider<Dio>((ref) {
  final storage = ref.watch(_secureStorageProvider);
  return DioClient(secureStorage: storage).dio;
});

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(dio: ref.watch(_dioProvider)),
);

// ── Auth state ────────────────────────────────────────────────────────────────

enum AuthStatus { initial, loading, authenticated, registered, error }

class AuthState {
  const AuthState({
    this.status = AuthStatus.initial,
    this.token,
    this.errorMessage,
  });

  final AuthStatus status;
  final String? token;
  final String? errorMessage;

  bool get isLoading => status == AuthStatus.loading;

  AuthState copyWith({
    AuthStatus? status,
    String? token,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      token: token ?? this.token,
      errorMessage: errorMessage,
    );
  }
}

// ── Auth Notifier ─────────────────────────────────────────────────────────────

class AuthNotifier extends Notifier<AuthState> {
  static const _tokenKey = 'jwt_token';

  @override
  AuthState build() {
    _restoreSession();
    return const AuthState();
  }

  FlutterSecureStorage get _storage => ref.read(_secureStorageProvider);
  AuthRepository get _repo => ref.read(authRepositoryProvider);

  Future<void> _restoreSession() async {
    final token = await _storage.read(key: _tokenKey);
    if (token != null) {
      state = AuthState(status: AuthStatus.authenticated, token: token);
    }
  }

  Future<void> login({required String email, required String password}) async {
    log('Attempting login for email: $email');
    state = const AuthState(status: AuthStatus.loading);
    try {
      final result = await _repo.login(email: email, password: password);
      log('Login successful. UserId: ${result.userId}');

      // Save all auth data to secure storage
      await Future.wait([
        _storage.write(key: _tokenKey, value: result.token),
        _storage.write(key: 'user_id', value: result.userId),
        _storage.write(key: 'user_name', value: result.name),
        _storage.write(key: 'user_email', value: result.email),
        _storage.write(key: 'user_role', value: result.role),
      ]);

      state = AuthState(status: AuthStatus.authenticated, token: result.token);
    } on DioException catch (e) {
      final msg = _extractError(e);
      log('Login failed with DioException: $msg', error: e);
      state = AuthState(status: AuthStatus.error, errorMessage: msg);
    } catch (e, stack) {
      log('Login failed with unknown error', error: e, stackTrace: stack);
      state = const AuthState(
        status: AuthStatus.error,
        errorMessage: 'Something went wrong. Please try again.',
      );
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    log('Attempting registration for email: $email');
    state = const AuthState(status: AuthStatus.loading);
    try {
      await _repo.register(name: name, email: email, password: password);
      log('Registration successful.');
      // We return registered state so the UI knows to push to /confirm-email
      // but we do NOT authenticate them since they must verify email and login again.
      state = const AuthState(status: AuthStatus.registered);
    } on DioException catch (e) {
      final msg = _extractError(e);
      log('Registration failed with DioException: $msg', error: e);
      state = AuthState(status: AuthStatus.error, errorMessage: msg);
    } catch (e, stack) {
      log(
        'Registration failed with unknown error',
        error: e,
        stackTrace: stack,
      );
      state = const AuthState(
        status: AuthStatus.error,
        errorMessage: 'Something went wrong. Please try again.',
      );
    }
  }

  Future<void> logout() async {
    await Future.wait([
      _storage.delete(key: _tokenKey),
      _storage.delete(key: 'user_id'),
      _storage.delete(key: 'user_name'),
      _storage.delete(key: 'user_email'),
      _storage.delete(key: 'user_role'),
    ]);
    state = const AuthState();
  }

  String _extractError(DioException e) {
    final data = e.response?.data;
    if (data is Map) {
      return data['message']?.toString() ??
          data['error']?.toString() ??
          'An error occurred.';
    }
    return e.message ?? 'An error occurred.';
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);
