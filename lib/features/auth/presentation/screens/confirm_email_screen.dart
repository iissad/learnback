import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:learnback/app/theme/app_colors.dart';
import 'package:learnback/app/theme/app_text_styles.dart';
import 'package:learnback/core/constants/app_spacing.dart';

class ConfirmEmailScreen extends StatelessWidget {
  const ConfirmEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBgPrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.md),

              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.blueLight,
                  ),
                  onPressed: () => context.pop(),
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // Glowing Icon
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.darkBgSecondary,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.blueLight.withValues(alpha: 0.2),
                        blurRadius: 40,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/confirm_email_icon.svg',
                      width: 50,
                      height: 50,
                      colorFilter: const ColorFilter.mode(
                        AppColors.cyan,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.xxl),

              const Text(
                'Check your emails',
                style: AppTextStyles.headingLarge,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppSpacing.md),

              const Text(
                'We have sent a confirmation link to your email address. Please click on the link to activate your account.',
                style: AppTextStyles.bodyMedium,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppSpacing.xxl),

              // Solid Blue Button
              SizedBox(
                height: 52,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    // TODO: Implement resend email logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Verification email resent!'),
                      ),
                    );
                  },
                  child: const Text(
                    'Resend email',
                    style: AppTextStyles.labelButton,
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              TextButton(
                onPressed: () => context.pushReplacement('/login'),
                child: Text(
                  'Back to login',
                  style: AppTextStyles.headingMedium.copyWith(
                    color: AppColors.blueLight,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const Spacer(),

              // Info Card
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.blue.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: AppColors.blueLight,
                      size: 20,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        "Can't find the email?\nCheck your spam folder.",
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.darkTextSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}
