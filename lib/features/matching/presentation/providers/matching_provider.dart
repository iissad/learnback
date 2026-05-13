import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnback/core/providers/common_providers.dart';
import 'package:learnback/features/matching/data/repositories/match_repository_impl.dart';
import 'package:learnback/features/matching/domain/repositories/match_repository.dart';
import 'package:learnback/features/skills/domain/models/skill.dart';
import 'package:learnback/features/skills/presentation/providers/skills_provider.dart';

final matchRepositoryProvider = Provider<MatchRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return MatchRepositoryImpl(dio: dio);
});

final popularSkillsProvider = FutureProvider<List<Skill>>((ref) async {
  final allSkills = await ref.watch(allSkillsProvider.future);
  if (allSkills.isEmpty) return [];

  final random = Random();
  final skills = List<Skill>.from(allSkills)..shuffle(random);
  return skills.take(2).toList();
});

final skillCategoriesProvider = FutureProvider<Map<String, List<Skill>>>((
  ref,
) async {
  final allSkills = await ref.watch(allSkillsProvider.future);
  final categories = <String, List<Skill>>{};

  for (final skill in allSkills) {
    final cat = skill.category ?? 'Other';
    if (!categories.containsKey(cat)) {
      categories[cat] = [];
    }
    categories[cat]!.add(skill);
  }

  return categories;
});
