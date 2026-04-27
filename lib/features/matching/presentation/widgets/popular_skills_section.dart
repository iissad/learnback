import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnback/app/theme/app_colors.dart';
import 'package:learnback/app/theme/app_text_styles.dart';
import 'package:learnback/core/constants/app_spacing.dart';
import 'package:learnback/features/skills/domain/models/skill.dart';
import '../providers/matching_provider.dart';

class PopularSkillsSection extends ConsumerWidget {
  const PopularSkillsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final popularSkillsAsync = ref.watch(popularSkillsProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 20,
                    decoration: BoxDecoration(
                      color: AppColors.colorForth,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'POPULAR SKILLS',
                    style: AppTextStyles.headingSmall.copyWith(
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'SEE ALL',
                  style: AppTextStyles.labelLink.copyWith(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: 180,
          child: popularSkillsAsync.when(
            data: (skills) {
              if (skills.isEmpty) {
                return const Center(child: Text('No popular skills found'));
              }
              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                scrollDirection: Axis.horizontal,
                itemCount: skills.length,
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  return _PopularSkillCard(skill: skills[index]);
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
          ),
        ),
      ],
    );
  }
}

class _PopularSkillCard extends StatelessWidget {
  const _PopularSkillCard({required this.skill});
  final Skill skill;

  @override
  Widget build(BuildContext context) {
    // Generate a background based on category or name
    final isDevelopment =
        skill.category?.toLowerCase() == 'development' ||
        skill.name.toLowerCase().contains('dev');

    return Container(
      width: 170, // Fixed width for matching screenshot look
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.darkBorder.withValues(alpha: 0.3)),
        image: DecorationImage(
          image: NetworkImage(
            isDevelopment
                ? 'https://images.unsplash.com/photo-1550751827-4bd374c3f58b?auto=format&fit=crop&q=80&w=400'
                : 'https://images.unsplash.com/photo-1558655146-d09347e92766?auto=format&fit=crop&q=80&w=400',
          ),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withValues(alpha: 0.5),
            BlendMode.darken,
          ),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  isDevelopment ? Icons.code_rounded : Icons.palette_rounded,
                  color: AppColors.cyan,
                  size: 24,
                ),
                const SizedBox(height: 4),
                Text(
                  skill.name.toUpperCase(),
                  style: AppTextStyles.headingSmall.copyWith(
                    color: AppColors.cyan,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
