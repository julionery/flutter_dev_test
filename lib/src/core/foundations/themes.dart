import 'package:flutter/material.dart';
import 'package:flutter_dev_test/src/core/foundations/colors.dart';
import 'package:flutter_dev_test/src/core/foundations/spacing.dart';
import 'package:flutter_dev_test/src/core/foundations/typography.dart';

class AppTheme {
  static const double defaultPadding = AppSpacing.$250;
  static const double defaultBorderRadius = AppSpacing.$100;

  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: AppColors.lightColorScheme,
      useMaterial3: true,
      fontFamily: 'PlusJakartaSans',
      textTheme: AppTypography.textTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textInvert,
          disabledBackgroundColor: AppColors.primary.withOpacity(0.5),
          disabledForegroundColor: AppColors.textInvert,
          elevation: 2,
          textStyle: AppTypography.labelMedium.copyWith(fontSize: 13, fontWeight: AppTypography.semiBold),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.$200, vertical: AppSpacing.$175),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultBorderRadius),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceLight,
        labelStyle: AppTypography.labelMedium.copyWith(color: AppColors.textOnBackground),
        hintStyle: AppTypography.labelMedium.copyWith(color: AppColors.textOnBackground),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: AppSpacing.$150, vertical: AppSpacing.$175),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: AppTypography.labelMedium.copyWith(
            fontSize: 13,
            fontWeight: AppTypography.semiBold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultBorderRadius),
          ),
          alignment: Alignment.center,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultBorderRadius),
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.textPrimary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
        ),
        contentTextStyle: AppTypography.labelMedium.copyWith(color: AppColors.textInvert),
        elevation: 6,
        insetPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.$250, vertical: AppSpacing.$225),
      ),
    );
  }
}
