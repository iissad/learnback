import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:learnback/app/theme/app_colors.dart';
import 'package:learnback/app/theme/app_text_styles.dart';
import 'package:learnback/core/constants/app_spacing.dart';
import '../providers/matching_provider.dart';
import 'category_card.dart';

class CategorySection extends ConsumerWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(skillCategoriesProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Row(
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
              const Text('Brows All', style: AppTextStyles.headingMedium),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        categoriesAsync.when(
          data: (categories) {
            if (categories.isEmpty) {
              return const Center(child: Text('No categories found'));
            }
            final sortedCategories = categories.keys.toList()..sort();
            return Column(
              children: sortedCategories.map((cat) {
                return CategoryCard(
                  category: cat,
                  skills: categories[cat]!,
                  onTap: () {
                    context.push('/matching/category/$cat');
                  },
                );
              }).toList(),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
        ),
      ],
    );
  }
}
