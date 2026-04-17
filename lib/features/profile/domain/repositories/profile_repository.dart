import '../models/user.dart';

abstract class ProfileRepository {
  Future<User> getProfile();
}
