import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learnback/app/theme/app_colors.dart';
import 'package:learnback/app/theme/app_text_styles.dart';
import 'package:learnback/core/constants/app_spacing.dart';
import '../widgets/popular_skills_section.dart';
import '../widgets/category_section.dart';

class MatchingScreen extends StatelessWidget {
  const MatchingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBgPrimary,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Column(
                children: [
                  const SizedBox(height: AppSpacing.md),
                  _buildTopBar(),
                  const SizedBox(height: AppSpacing.lg),
                  _buildSearchBar(),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            const Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    PopularSkillsSection(),
                    const SizedBox(height: AppSpacing.xl),
                    CategorySection(),
                    const SizedBox(height: AppSpacing.xxl),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset('assets/icons/logo.png', width: 40, height: 40),
        const Text('Matching', style: AppTextStyles.headingLarge),
        SvgPicture.asset(
          'assets/icons/notification.svg',
          width: 28,
          height: 28,
          colorFilter: const ColorFilter.mode(
            AppColors.darkTextSecondary,
            BlendMode.srcIn,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.darkBgSecondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search_rounded,
            color: AppColors.darkTextSecondary.withValues(alpha: 0.6),
            size: 25,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              style: AppTextStyles.bodyLarge.copyWith(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search matching...',
                hintStyle: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.darkTextSecondary.withValues(alpha: 0.6),
                  fontSize: 16,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          Icon(
            Icons.filter_list_rounded,
            // We use darkTextSecondary instead of blueLight for safety since blueLight might not be used here, but HomeScreen used blueLight. Wait, blueLight was in HomeScreen, let's use colorThird which is the interactive blue element from Figma. Actually wait.
            color: AppColors.colorThird.withValues(alpha: 0.6),
            size: 25,
          ),
        ],
      ),
    );
  }
}
