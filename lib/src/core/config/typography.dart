import 'package:flutter/material.dart';
import 'package:flutter_dev_test/src/core/config/colors.dart';

/// Typography class that defines text styles for the application
class AppTypography {
  AppTypography._();

  // Font family
  static const String fontFamily = 'PlusJakartaSans';

  // Font Weights
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  // Text Colors - Using the app's color definitions
  static const Color _primaryTextColor = AppColors.textPrimary;
  static const Color _secondaryTextColor = AppColors.textSecondary;
  static const Color _onBackgroundTextColor = AppColors.textOnBackground;
  static const Color _lightColor = AppColors.white;

  // Display Styles
  static TextStyle get displayLarge => TextStyle(
        fontFamily: fontFamily,
        fontSize: 57,
        height: 1.12,
        letterSpacing: -0.25,
        fontWeight: semiBold,
        color: _primaryTextColor,
      );

  static TextStyle get displayMedium => TextStyle(
        fontFamily: fontFamily,
        fontSize: 45,
        height: 1.15,
        letterSpacing: -0.25,
        fontWeight: semiBold,
        color: _primaryTextColor,
      );

  static TextStyle get displaySmall => TextStyle(
        fontFamily: fontFamily,
        fontSize: 36,
        height: 1.2,
        letterSpacing: 0,
        fontWeight: semiBold,
        color: _primaryTextColor,
      );

  // Headline Styles
  static TextStyle get headlineLarge => TextStyle(
        fontFamily: fontFamily,
        fontSize: 32,
        height: 1.25,
        letterSpacing: 0,
        fontWeight: semiBold,
        color: _primaryTextColor,
      );

  static TextStyle get headlineMedium => TextStyle(
        fontFamily: fontFamily,
        fontSize: 28,
        height: 1.28,
        letterSpacing: 0,
        fontWeight: semiBold,
        color: _primaryTextColor,
      );

  static TextStyle get headlineSmall => TextStyle(
        fontFamily: fontFamily,
        fontSize: 24,
        height: 1.33,
        letterSpacing: 0,
        fontWeight: semiBold,
        color: _primaryTextColor,
      );

  // Title Styles
  static TextStyle get titleLarge => TextStyle(
        fontFamily: fontFamily,
        fontSize: 22,
        height: 1.27,
        letterSpacing: 0,
        fontWeight: semiBold,
        color: _primaryTextColor,
      );

  static TextStyle get titleMedium => TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        height: 1.5,
        letterSpacing: 0.15,
        fontWeight: semiBold,
        color: _primaryTextColor,
      );

  static TextStyle get titleSmall => TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        height: 1.42,
        letterSpacing: 0.1,
        fontWeight: semiBold,
        color: _primaryTextColor,
      );

  // Body Styles
  static TextStyle get bodyLarge => TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        height: 1.5,
        letterSpacing: 0.15,
        fontWeight: regular,
        color: _primaryTextColor,
      );

  static TextStyle get bodyMedium => TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        height: 1.42,
        letterSpacing: 0.25,
        fontWeight: regular,
        color: _primaryTextColor,
      );

  static TextStyle get bodySmall => TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        height: 1.33,
        letterSpacing: 0.4,
        fontWeight: regular,
        color: _secondaryTextColor,
      );

  // Label Styles
  static TextStyle get labelLarge => TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        height: 1.42,
        letterSpacing: 0.1,
        fontWeight: medium,
        color: _primaryTextColor,
      );

  static TextStyle get labelMedium => TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        height: 1.33,
        letterSpacing: 0.5,
        fontWeight: medium,
        color: _primaryTextColor,
      );

  static TextStyle get labelSmall => TextStyle(
        fontFamily: fontFamily,
        fontSize: 11,
        height: 1.45,
        letterSpacing: 0.5,
        fontWeight: medium,
        color: _primaryTextColor,
      );

  // Helper methods to quickly get variations
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }

  static TextStyle withWeight(TextStyle style, FontWeight weight) {
    return style.copyWith(fontWeight: weight);
  }

  // Create a TextTheme using our typography styles
  static TextTheme get textTheme => TextTheme(
        displayLarge: displayLarge,
        displayMedium: displayMedium,
        displaySmall: displaySmall,
        headlineLarge: headlineLarge,
        headlineMedium: headlineMedium,
        headlineSmall: headlineSmall,
        titleLarge: titleLarge,
        titleMedium: titleMedium,
        titleSmall: titleSmall,
        bodyLarge: bodyLarge,
        bodyMedium: bodyMedium,
        bodySmall: bodySmall,
        labelLarge: labelLarge,
        labelMedium: labelMedium,
        labelSmall: labelSmall,
      );
}
