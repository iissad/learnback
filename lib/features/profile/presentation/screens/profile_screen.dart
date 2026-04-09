import 'package:flutter/material.dart';
import 'package:learnback/app/theme/app_colors.dart';
import 'package:learnback/app/theme/app_text_styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.darkBgPrimary,
      body: Center(
        child: Text('Profile Screen', style: AppTextStyles.headingLarge),
      ),
    );
  }
}
