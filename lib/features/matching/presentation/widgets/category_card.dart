import 'package:flutter/material.dart';
import 'package:learnback/app/theme/app_colors.dart';
import 'package:learnback/app/theme/app_text_styles.dart';
import 'package:learnback/core/constants/app_spacing.dart';
import 'package:learnback/features/skills/domain/models/skill.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.category,
    required this.skills,
    required this.onTap,
  });

  final String category;
  final List<Skill> skills;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // Determine icon based on category name
    IconData iconData;
    switch (category.toLowerCase()) {
      case 'languages':
        iconData = Icons.translate_rounded;
        break;
      case 'business':
        iconData = Icons.business_center_rounded;
        break;
      case 'personal growth':
        iconData = Icons.self_improvement_rounded;
        break;
      case 'development':
        iconData = Icons.code_rounded;
        break;
      case 'design':
        iconData = Icons.palette_rounded;
        break;
      default:
        iconData = Icons.category_rounded;
    }

    final skillNames = skills.take(3).map((s) => s.name).join(', ');
    final subtitle = skills.length > 3 ? '$skillNames..' : skillNames;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: 8,
        ),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.darkBgSecondary.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.darkBorder.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.darkBgSecondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(iconData, color: AppColors.colorThird, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category,
                    style: AppTextStyles.headingSmall.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.darkTextSecondary.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'SEE ALL',
              style: AppTextStyles.labelLink.copyWith(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
