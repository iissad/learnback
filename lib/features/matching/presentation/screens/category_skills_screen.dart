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

  void _showMatchAction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.darkBgSecondary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.darkBorder.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.blueLight.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.handshake_rounded,
                  color: AppColors.blueLight,
                  size: 40,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Ready to swap skills?',
                style: AppTextStyles.headingMedium.copyWith(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'We will find peers who want to learn ${skill.name} and can teach you something valuable in return.',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.darkTextSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
              GradientButton(
                label: 'Get Matched Now',
                onPressed: () {
                  Navigator.pop(context);
                  // TODO: Implement matching flow via provider
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Finding your perfect match for ${skill.name}...',
                      ),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: AppColors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: AppSpacing.md),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Maybe later',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.darkTextSecondary,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showMatchAction(context),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.darkBgSecondary,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.darkBorder.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.darkBgPrimary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.psychology_rounded,
                    color: AppColors.blueLight,
                    size: 24,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        skill.name,
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      if (skill.description != null)
                        Text(
                          skill.description!,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.darkTextSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.darkTextSecondary,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
