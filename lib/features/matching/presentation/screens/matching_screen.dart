import 'package:flutter/material.dart';
import 'package:learnback/app/theme/app_colors.dart';
import 'package:learnback/app/theme/app_text_styles.dart';

class MatchingScreen extends StatelessWidget {
  const MatchingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.darkBgPrimary,
      body: Center(
        child: Text('Matching Screen', style: AppTextStyles.headingLarge),
      ),
    );
  }
}
