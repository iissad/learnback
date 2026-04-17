import 'package:dio/dio.dart';
import '../../domain/models/user.dart';
import '../../domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final Dio _dio;

  ProfileRepositoryImpl({required Dio dio}) : _dio = dio;

  @override
  Future<User> getProfile() async {
    final response = await _dio.get('/api/users/profile');
    // Assuming backend returns { success: true, user: { ... } } or just the user
    // Based on context: GET /api/users/profile returns { name, profile, points, ... }
    // Let's assume the body is the user object for now, or check further.
    // The previous implementation used 'result.userId' from getProfile in AuthNotifier.
    // Let's see how AuthRepository.getProfile was implemented.
    return User.fromJson(response.data);
  }
}
