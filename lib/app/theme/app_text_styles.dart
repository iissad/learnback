import 'package:flutter/material.dart';
import 'app_colors.dart';

/// All design-token text styles for LearnBack.
/// Never hardcode font sizes in widgets – always use AppTextStyles.*
abstract class AppTextStyles {
  static const String _font = 'SpaceGrotesk';

  static const TextStyle displayLarge = TextStyle(
    fontFamily: _font,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.darkTextPrimary,
  );

  static const TextStyle headingLarge = TextStyle(
    fontFamily: _font,
    fontSize: 26,
    fontWeight: FontWeight.w600,
    color: AppColors.darkTextPrimary,
  );

  static const TextStyle headingMedium = TextStyle(
    fontFamily: _font,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.darkTextPrimary,
  );

  static const TextStyle headingSmall = TextStyle(
    fontFamily: _font,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.darkTextPrimary,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: _font,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.darkTextPrimary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: _font,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.darkTextSecondary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: _font,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.darkTextSecondary,
  );

  static const TextStyle labelButton = TextStyle(
    fontFamily: _font,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const TextStyle labelLink = TextStyle(
    fontFamily: _font,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.blueLight,
  );

  static const TextStyle errorText = TextStyle(
    fontFamily: _font,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.error,
  );
}
