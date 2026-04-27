import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learnback/app/theme/app_colors.dart';
import 'package:learnback/app/theme/app_text_styles.dart';
import 'package:learnback/core/constants/app_spacing.dart';
import 'package:learnback/features/verification/domain/models/skill_test.dart';

class VerificationResultScreen extends StatelessWidget {
  const VerificationResultScreen({super.key, required this.result});

  final QuizSubmissionResponse result;

  @override
  Widget build(BuildContext context) {
    final passed = result.passed;

    return Scaffold(
      backgroundColor: AppColors.darkBgPrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xxl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              _ResultIcon(passed: passed),
              const SizedBox(height: AppSpacing.xl),
              Text(
                passed ? 'Congratulations!' : 'Keep Learning!',
                style: AppTextStyles.headingLarge.copyWith(
                  color: passed ? AppColors.success : AppColors.error,
                  fontSize: 32,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                passed
                    ? 'You have successfully verified your skill and earned 50 points!'
                    : 'You didn\'t reach the passing score this time. Don\'t give up!',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.darkTextSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xxl),
              _ScoreCard(score: result.score, passed: passed),
              const Spacer(),
              _ActionButtons(passed: passed),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResultIcon extends StatelessWidget {
  const _ResultIcon({required this.passed});
  final bool passed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: (passed ? AppColors.success : AppColors.error).withValues(
          alpha: 0.1,
        ),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          passed ? Icons.check_circle_rounded : Icons.cancel_rounded,
          color: passed ? AppColors.success : AppColors.error,
          size: 80,
        ),
      ),
    );
  }
}

class _ScoreCard extends StatelessWidget {
  const _ScoreCard({required this.score, required this.passed});
  final int score;
  final bool passed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.darkBgSecondary,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: (passed ? AppColors.success : AppColors.error).withValues(
            alpha: 0.2,
          ),
        ),
      ),
      child: Column(
        children: [
          Text(
            'YOUR SCORE',
            style: AppTextStyles.bodySmall.copyWith(
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '$score%',
            style: AppTextStyles.displayLarge.copyWith(
              color: passed ? AppColors.success : AppColors.error,
              fontSize: 48,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons({required this.passed});
  final bool passed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: () => context.go('/home'),
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              gradient: AppColors.ctaGradient,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(
                'Back to Home',
                style: AppTextStyles.labelButton.copyWith(fontSize: 18),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        TextButton(
          onPressed: () => context.pop(),
          child: Text(
            passed ? 'View My Skills' : 'Try Again Later',
            style: AppTextStyles.labelLink.copyWith(
              color: AppColors.darkTextSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
