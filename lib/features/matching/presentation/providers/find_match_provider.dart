import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/match_result.dart';
import 'matching_provider.dart';

class FindMatchNotifier extends AsyncNotifier<MatchResult?> {
  @override
  Future<MatchResult?> build() async {
    return null;
  }

  Future<void> findMatch(String learnSkillId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return ref.read(matchRepositoryProvider).findMatch(learnSkillId);
    });
  }

  void reset() {
    state = const AsyncData(null);
  }
}

final findMatchProvider =
    AsyncNotifierProvider<FindMatchNotifier, MatchResult?>(
      FindMatchNotifier.new,
    );
