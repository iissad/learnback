import '../models/user.dart';

abstract class ProfileRepository {
  Future<User> getProfile();
  Future<User> updateProfile({
    String? name,
    String? avatar,
    String? bio,
    String? location,
  });
}
