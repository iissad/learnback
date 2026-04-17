import 'package:flutter/material.dart';

/// All design-token colors for LearnBack.
/// Never hardcode hex values in widgets – always use AppColors.*
abstract class AppColors {
  // ── Dark mode backgrounds ──────────────────────────────────────────
  static const Color darkBgPrimary = Color(0xFF0A192F);
  static const Color darkBgSecondary = Color(0xFF1E293B);

  // ── Dark mode text ─────────────────────────────────────────────────
  static const Color darkTextPrimary = Colors.white;
  static const Color darkTextSecondary = Color(0xFF8892B0);

  // ── Light mode backgrounds ─────────────────────────────────────────
  static const Color lightBgPrimary = Color(0xFFD9EAFD);
  static const Color lightTextPrimary = Color(0xFF0A192F);
  static const Color lightTextSecondary = Color(0xFF112240);
  static const Color lightBorder = Color(0xFFBCCCDC);
  static const Color lightTextMuted = Color(0xFF9AA6B2);

  // ── Accent ─────────────────────────────────────────────────────────
  static const Color cyan = Color(0xFF00F2FE); // gradient start / links
  static const Color colorFifth = cyan;
  static const Color purple = Color(0xFF7367F0); // gradient end
  static const Color colorSixth = purple;
  static const Color blue = Color(0xFF4988C4);
  static const Color colorThird = blue;
  static const Color blueLight = Color(0xFF13A4EC);
  static const Color colorForth = blueLight;
  static const Color darkBorder = Color(0xFF4988C4);

  // ── Semantic ───────────────────────────────────────────────────────
  static const Color error = Color(0xFFFF4D6A);
  static const Color success = Color(0xFF00F2FE);
  static const Color warning = Color(0xFFFFB84D);

  // ── Gradient ───────────────────────────────────────────────────────
  static const LinearGradient ctaGradient = LinearGradient(
    colors: [cyan, purple],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
