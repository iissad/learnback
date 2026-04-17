import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnback/core/providers/common_providers.dart';
import '../../data/repositories/skills_repository_impl.dart';
import '../../domain/repositories/skills_repository.dart';
import '../../domain/models/user_skill.dart';
import '../../domain/models/learning_goal.dart';

final skillsRepositoryProvider = Provider<SkillsRepository>((ref) {
  return SkillsRepositoryImpl(dio: ref.watch(dioProvider));
});

final userSkillsProvider = FutureProvider<List<UserSkill>>((ref) async {
  final repo = ref.watch(skillsRepositoryProvider);
  return repo.getUserSkills();
});

final userGoalsProvider = FutureProvider<List<LearningGoal>>((ref) async {
  final repo = ref.watch(skillsRepositoryProvider);
  return repo.getUserGoals();
});
