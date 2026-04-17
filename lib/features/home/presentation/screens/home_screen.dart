import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learnback/app/theme/app_colors.dart';
import 'package:learnback/app/theme/app_text_styles.dart';
import 'package:learnback/core/constants/app_spacing.dart';
import 'package:learnback/features/profile/presentation/providers/profile_provider.dart';
import 'package:learnback/features/skills/presentation/providers/skills_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);
    final userSkillsAsync = ref.watch(userSkillsProvider);
    final userGoalsAsync = ref.watch(userGoalsProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBgPrimary,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(profileProvider);
            ref.invalidate(userSkillsProvider);
            ref.invalidate(userGoalsProvider);
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSpacing.md),
                // 1. Logo, Name, Notifications & Search Bar
                _buildTopBar(),
                const SizedBox(height: AppSpacing.lg),
                _buildSearchBar(),
                const SizedBox(height: AppSpacing.xl),

                // 2. Score and Streak fields
                profileAsync.when(
                  data: (user) => _buildScoreAndStreakRow(user.points),
                  loading: () => _buildScoreAndStreakRow(0, isLoading: true),
                  error: (err, stack) => _buildScoreAndStreakRow(0),
                ),
                const SizedBox(height: AppSpacing.lg),

                // 3. Welcome message
                profileAsync.when(
                  data: (user) => Text(
                    'Welcome back, ${user.name}',
                    style: AppTextStyles.headingLarge,
                  ),
                  loading: () => const Text(
                    'Welcome back',
                    style: AppTextStyles.headingLarge,
                  ),
                  error: (err, stack) => const Text(
                    'Welcome back',
                    style: AppTextStyles.headingLarge,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),

                // 4. Active project section
                _buildSectionHeader('Active projects'),
                const SizedBox(height: AppSpacing.sm),
                _buildProjectCard(),
                const SizedBox(height: AppSpacing.xl),

                // 5. Learning goals and Mastered skills
                Row(
                  children: [
                    Expanded(
                      child: userGoalsAsync.when(
                        data: (goals) => _buildStatCard(
                          'Learning Goals',
                          goals.length.toString(),
                          subtitle: goals.isEmpty ? 'Set some goals!' : null,
                        ),
                        loading: () => _buildStatCard(
                          'Learning Goals',
                          '...',
                          isLoading: true,
                        ),
                        error: (_, __) => _buildStatCard('Learning Goals', '0'),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: userSkillsAsync.when(
                        data: (skills) => _buildStatCard(
                          'Mastered Skills',
                          skills.length.toString(),
                          subtitle: skills.isEmpty ? 'Start learning!' : null,
                        ),
                        loading: () => _buildStatCard(
                          'Mastered Skills',
                          '...',
                          isLoading: true,
                        ),
                        error: (_, __) =>
                            _buildStatCard('Mastered Skills', '0'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // TODO: Navigate to edit skills/goals
                    },
                    child: const Text(
                      'Edit Lists',
                      style: AppTextStyles.labelLink,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xxl),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset('assets/icons/logo.png', width: 40, height: 40),
            const SizedBox(width: 8),
            const Text('LearnBack', style: AppTextStyles.headingLarge),
          ],
        ),
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
        border: Border.all(
          color: AppColors.darkBorder.withValues(alpha: 0.3),
          width: 1,
        ),
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
                hintText: 'Search learning tracks...',
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
            color: AppColors.colorFifth.withValues(alpha: 0.6),
            size: 25,
          ),
        ],
      ),
    );
  }

  Widget _buildScoreAndStreakRow(int score, {bool isLoading = false}) {
    return Row(
      children: [
        Expanded(
          child: _buildInfoField(
            'Score',
            isLoading ? '...' : score.toString(),
            Icons.stars_rounded,
            AppColors.colorFifth,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: _buildInfoField(
            'Streak',
            '12 days 🔥',
            Icons.local_fire_department_rounded,
            Colors.orangeAccent,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoField(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.darkBgSecondary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.darkBorder.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.darkTextSecondary,
                ),
              ),
              Text(
                value,
                style: AppTextStyles.headingSmall.copyWith(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(title, style: AppTextStyles.headingSmall);
  }

  Widget _buildProjectCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.darkBgSecondary,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.darkBorder.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: const Center(
        child: Text(
          'You have no active projects yet, so no linking for now.',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyMedium,
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value, {
    String? subtitle,
    bool isLoading = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.darkBgSecondary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.darkBorder.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.darkTextSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTextStyles.headingLarge.copyWith(
              color: AppColors.colorFifth,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.colorFifth.withValues(alpha: 0.8),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
