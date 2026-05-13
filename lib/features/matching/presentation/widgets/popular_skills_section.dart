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
        popularSkillsAsync.when(
          data: (skills) {
            if (skills.length < 2) {
              return const SizedBox(
                height: 180,
                child: Center(child: Text('Not enough popular skills')),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Row(
                children: [
                  Expanded(
                    child: _PopularSkillCard(
                      skill: skills[0],
                      backgroundImage: 'assets/images/development_bg.png',
                      icon: Icons.code_rounded,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _PopularSkillCard(
                      skill: skills[1],
                      backgroundImage: 'assets/images/design_bg.png',
                      icon: Icons.palette_rounded,
                    ),
                  ),
                ],
              ),
            );
          },
          loading: () => const SizedBox(
            height: 180,
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (e, _) =>
              SizedBox(height: 180, child: Center(child: Text('Error: $e'))),
        ),
      ],
    );
  }
}

class _PopularSkillCard extends StatelessWidget {
  const _PopularSkillCard({
    required this.skill,
    required this.backgroundImage,
    required this.icon,
  });

  final Skill skill;
  final String backgroundImage;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.darkBorder.withValues(alpha: 0.3)),
        image: DecorationImage(
          image: AssetImage(backgroundImage),
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
                Icon(icon, color: AppColors.blueLight, size: 24),
                const SizedBox(height: 4),
                Text(
                  skill.name.toUpperCase(),
                  style: AppTextStyles.headingSmall.copyWith(
                    color: AppColors.blueLight,
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
