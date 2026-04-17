import 'package:dio/dio.dart';
import '../../domain/models/user.dart';
import '../../domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final Dio _dio;

  ProfileRepositoryImpl({required Dio dio}) : _dio = dio;

  @override
  Future<User> getProfile() async {
    final response = await _dio.get('users/profile');
    final responseBody = response.data as Map<String, dynamic>;
    final d = responseBody['data'] as Map<String, dynamic>;
    final profile = d['profile'] as Map<String, dynamic>? ?? {};
    return User.fromJson({
      'id': d['_id'],
      'name': d['name'],
      'email': d['email'],
      'points': d['points'],
      'role': d['role'],
      'avatar': profile['avatar'],
      'bio': profile['bio'],
      'location': profile['location'],
    });
  }
}
