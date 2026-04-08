import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learnback/app/theme/app_colors.dart';
import 'package:learnback/app/theme/app_text_styles.dart';
import 'package:learnback/core/constants/app_spacing.dart';
import 'package:learnback/shared/widgets/gradient_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBgPrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Logo Image
              Image.asset(
                'assets/icons/logo.png',
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: AppSpacing.lg),

              // App Name
              const Text('LearnBack', style: AppTextStyles.displayLarge),

              const SizedBox(height: AppSpacing.sm),

              // Subtitle
              const Text(
                'Amplify your skills. Connect. Learn. Empower.',
                style: AppTextStyles.bodyMedium,
                textAlign: TextAlign.center,
              ),

              const Spacer(),

              // Get Started Button
              GradientButton(
                label: 'Get started',
                onPressed: () => context.push('/register'),
              ),

              const SizedBox(height: AppSpacing.md),

              // Log In Button
              TextButton(
                onPressed: () => context.push('/login'),
                child: Text(
                  'Log In',
                  style: AppTextStyles.headingMedium.copyWith(
                    color: AppColors.blueLight,
                    fontWeight: FontWeight.w500,
                  ),
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
