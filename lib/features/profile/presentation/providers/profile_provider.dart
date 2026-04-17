import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnback/core/providers/common_providers.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../domain/models/user.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepositoryImpl(dio: ref.watch(dioProvider));
});

class UserProfileNotifier extends AsyncNotifier<User> {
  @override
  Future<User> build() async {
    final repo = ref.watch(profileRepositoryProvider);
    return repo.getProfile();
  }

  Future<void> updateProfile({
    String? name,
    String? avatar,
    String? bio,
    String? location,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(profileRepositoryProvider);
      final updatedUser = await repo.updateProfile(
        name: name,
        avatar: avatar,
        bio: bio,
        location: location,
      );
      if (avatar != null) {
        final storage = ref.read(secureStorageProvider);
        await storage.write(key: 'user_avatar', value: avatar);
      }
      return updatedUser;
    });
  }
}

final profileProvider = AsyncNotifierProvider<UserProfileNotifier, User>(
  UserProfileNotifier.new,
);
