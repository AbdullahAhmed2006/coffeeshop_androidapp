import 'package:flutter/material.dart';

class AppColors {
  // Primary Accent
  static const Color kPrimaryOrange = Color(0xFFD17842);
  static const Color kPrimaryOrangeLight = Color(0xFFE58D58);

  // Dark Theme Palette
  static const Color kBackgroundDark = Color(0xFF0C0F14);
  static const Color kCardDark = Color(0xFF141921);
  static const Color kCardDarkAlt = Color(0xFF252A32);
  static const Color kTextPrimaryDark = Colors.white;
  static const Color kTextSecondaryDark = Color(0xFFAEAEAE);
  static const Color kGreyText = Color(0xFF52555A);
  static const Color kBorderDark = Color(0xFF252A32);

  // Light Theme Palette
  static const Color kBackgroundLight = Color(0xFFF7F8FA);
  static const Color kCardLight = Color(0xFFFFFFFF);
  static const Color kCardLightAlt = Color(0xFFECEFF2);
  static const Color kTextPrimaryLight = Color(0xFF1A1D23);
  static const Color kTextSecondaryLight = Color(0xFF6E7480);
  static const Color kBorderLight = Color(0xFFE5E7EB);

  // Shared
  static const Color kFavoriteRed = Color(0xFFDC3535);
  static const Color kWhite = Colors.white;
  static const Color kLightGrey = Color(0xFFAEAEAE);
  static const Color kStarGold = Color(0xFFFFB800);

  // Context-aware color helpers
  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static Color background(BuildContext context) =>
      isDark(context) ? kBackgroundDark : kBackgroundLight;

  static Color card(BuildContext context) =>
      isDark(context) ? kCardDark : kCardLight;

  static Color cardAlt(BuildContext context) =>
      isDark(context) ? kCardDarkAlt : kCardLightAlt;

  static Color textPrimary(BuildContext context) =>
      isDark(context) ? kTextPrimaryDark : kTextPrimaryLight;

  static Color textSecondary(BuildContext context) =>
      isDark(context) ? kTextSecondaryDark : kTextSecondaryLight;

  static Color border(BuildContext context) =>
      isDark(context) ? kBorderDark : kBorderLight;
}
