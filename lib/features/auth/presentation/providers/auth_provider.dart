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

enum AuthStatus { initial, loading, authenticated, error }

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
    state = const AuthState(status: AuthStatus.loading);
    try {
      final result = await _repo.login(email: email, password: password);
      await _storage.write(key: _tokenKey, value: result.token);
      state = AuthState(status: AuthStatus.authenticated, token: result.token);
    } on DioException catch (e) {
      final msg = _extractError(e);
      state = AuthState(status: AuthStatus.error, errorMessage: msg);
    } catch (_) {
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
    state = const AuthState(status: AuthStatus.loading);
    try {
      final result = await _repo.register(
        name: name,
        email: email,
        password: password,
      );
      await _storage.write(key: _tokenKey, value: result.token);
      state = AuthState(status: AuthStatus.authenticated, token: result.token);
    } on DioException catch (e) {
      final msg = _extractError(e);
      state = AuthState(status: AuthStatus.error, errorMessage: msg);
    } catch (_) {
      state = const AuthState(
        status: AuthStatus.error,
        errorMessage: 'Something went wrong. Please try again.',
      );
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: _tokenKey);
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
