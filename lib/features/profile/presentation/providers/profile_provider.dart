import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnback/core/providers/common_providers.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../domain/models/user.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepositoryImpl(dio: ref.watch(dioProvider));
});

final profileProvider = FutureProvider<User>((ref) async {
  final repo = ref.watch(profileRepositoryProvider);
  return repo.getProfile();
});
