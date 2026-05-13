import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:learnback/app/theme/app_colors.dart';
import 'package:learnback/app/theme/app_text_styles.dart';
import 'package:learnback/core/constants/app_spacing.dart';
import 'package:learnback/features/matching/domain/models/match_result.dart';
import 'package:learnback/features/matching/domain/models/user_review.dart';
import 'package:learnback/features/matching/presentation/providers/user_reviews_provider.dart';
import 'package:learnback/features/matching/presentation/providers/matching_provider.dart';
import 'package:learnback/shared/widgets/gradient_button.dart';

class MatchProfileScreen extends ConsumerWidget {
  const MatchProfileScreen({super.key, required this.match});

  final MatchResult match;

  void _handleAccept(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(matchRepositoryProvider).approveMatch(match.matchId);
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Match accepted! You can now start learning together.'),
          backgroundColor: AppColors.success,
        ),
      );
      context.go('/home');
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.error),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewsAsync = ref.watch(userReviewsProvider(match.peerId));

    return Scaffold(
      backgroundColor: AppColors.darkBgPrimary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.white),
        title: Text('Match\'s profile', style: AppTextStyles.headingMedium),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ), // horizontalPadding: 24px as per design.md
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.lg),
            _buildProfileHeader(),
            const SizedBox(height: AppSpacing.xl),
            reviewsAsync.when(
              data: (reviews) => _buildStatsRow(reviews),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error loading reviews')),
            ),
            const SizedBox(height: AppSpacing.xl),
            reviewsAsync.when(
              data: (reviews) => _buildRatingBreakdown(reviews),
              loading: () => const SizedBox.shrink(),
              error: (e, _) => const SizedBox.shrink(),
            ),
            const SizedBox(height: AppSpacing.xl),
            reviewsAsync.when(
              data: (reviews) => _buildReviewsSection(reviews),
              loading: () => const SizedBox.shrink(),
              error: (e, _) => const SizedBox.shrink(),
            ),
            const SizedBox(height: AppSpacing.xxl),
            GradientButton(
              label: 'Accept request',
              onPressed: () => _handleAccept(context, ref),
            ),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.blueLight, width: 2),
          ),
          child: CircleAvatar(
            radius: 60,
            backgroundImage:
                match.peerAvatar != null && match.peerAvatar!.isNotEmpty
                ? AssetImage('assets/avatars/${match.peerAvatar}')
                : null,
            child: (match.peerAvatar == null || match.peerAvatar!.isEmpty)
                ? Text(
                    match.peerName.characters.first.toUpperCase(),
                    style: AppTextStyles.displayLarge,
                  )
                : null,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(match.peerName, style: AppTextStyles.headingLarge),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Learning Enthusiast since Jan 2024',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.darkTextSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow(List<UserReview> reviews) {
    double avgRating = 0;
    if (reviews.isNotEmpty) {
      avgRating =
          reviews.map((e) => e.rating).reduce((a, b) => a + b) / reviews.length;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatCard(
          '${avgRating.toStringAsFixed(2)}/5',
          'Rating',
          AppColors.blueLight,
        ),
        _buildStatCard(
          match.skillYouLearn, // Peer teaches what user learns
          'Skill\nto teach',
          AppColors.blueLight,
        ),
        _buildStatCard(
          match.skillYouTeach, // Peer learns what user teaches
          'Skill\nto learn',
          AppColors.blueLight,
        ),
      ],
    );
  }

  Widget _buildStatCard(String value, String label, Color valueColor) {
    return Container(
      width: 110,
      height: 100,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.darkBgSecondary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.blue.withValues(alpha: 0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: AppTextStyles.headingSmall.copyWith(
              color: valueColor,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.darkTextSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRatingBreakdown(List<UserReview> reviews) {
    final counts = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};
    for (var r in reviews) {
      final ratingInt = r.rating.toInt();
      if (counts.containsKey(ratingInt)) {
        counts[ratingInt] = counts[ratingInt]! + 1;
      }
    }

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.darkBgSecondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Rating', style: AppTextStyles.headingSmall),
          const SizedBox(height: AppSpacing.md),
          ...[5, 4, 3, 2, 1].map((stars) {
            final count = counts[stars] ?? 0;
            final percentage = reviews.isEmpty ? 0.0 : count / reviews.length;
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Row(
                children: [
                  SizedBox(
                    width: 15,
                    child: Text(
                      '$stars',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: percentage,
                        backgroundColor: AppColors.darkBgPrimary,
                        color: AppColors.blueLight,
                        minHeight: 8,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  SizedBox(
                    width: 35,
                    child: Text(
                      '${(percentage * 100).toInt()}%',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.blueLight,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildReviewsSection(List<UserReview> reviews) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Reviews', style: AppTextStyles.headingSmall),
            TextButton(
              onPressed: () {},
              child: Text(
                'View All',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.blueLight,
                ),
              ),
            ),
          ],
        ),
        if (reviews.isEmpty)
          const Center(child: Text('No reviews yet'))
        else
          ...reviews.take(2).map((r) => _buildReviewCard(r)),
      ],
    );
  }

  Widget _buildReviewCard(UserReview review) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.darkBgSecondary.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.blue.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.darkBgPrimary,
                child: review.reviewerAvatar != null
                    ? null
                    : Text(
                        (review.reviewerName ?? 'U').characters.first
                            .toUpperCase(),
                        style: AppTextStyles.bodySmall.copyWith(
                          color: Colors.white,
                        ),
                      ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.reviewerName ?? 'Anonymous User',
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < review.rating
                              ? Icons.star_rounded
                              : Icons.star_outline_rounded,
                          color: AppColors.blueLight,
                          size: 14,
                        );
                      }),
                    ),
                  ],
                ),
              ),
              Text(
                '2d ago', // Mock date as not in API
                style: AppTextStyles.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            review.comment ?? review.review,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.darkTextSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
