import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnback/app/theme/app_colors.dart';
import 'package:learnback/app/theme/app_text_styles.dart';
import 'package:learnback/core/constants/app_spacing.dart';
import 'package:learnback/shared/widgets/gradient_button.dart';
import '../../../skills/domain/models/skill.dart';
import '../providers/matching_provider.dart';

class CategorySkillsScreen extends ConsumerWidget {
  const CategorySkillsScreen({super.key, required this.category});

  final String category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(skillCategoriesProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBgPrimary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.white),
        title: Text(category, style: AppTextStyles.headingMedium),
      ),
      body: categoriesAsync.when(
        data: (categories) {
          final skills = categories[category] ?? [];
          if (skills.isEmpty) {
            return const Center(child: Text('No skills in this category'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(AppSpacing.lg),
            itemCount: skills.length,
            itemBuilder: (context, index) {
              return _SkillListItem(skill: skills[index]);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

class _SkillListItem extends StatelessWidget {
  const _SkillListItem({required this.skill});
  final Skill skill;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkBgSecondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      skill.name,
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    if (skill.description != null)
                      Text(
                        skill.description!,
                        style: AppTextStyles.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.blueLight,
              ),
            ],
          ),
          const SizedBox(height: 16),
          GradientButton(
            label: 'Get Matched',
            onPressed: () {
              // TODO: Implement matching flow
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Finding a match for ${skill.name}...')),
              );
            },
            height: 40,
          ),
        ],
      ),
    );
  }
}
