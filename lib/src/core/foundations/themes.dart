import 'package:flutter/material.dart';
import 'package:flutter_dev_test/src/core/foundations/colors.dart';
import 'package:flutter_dev_test/src/core/foundations/typography.dart';

class AppTheme {
  static const double defaultPadding = 24.0;
  static const double defaultBorderRadius = 12.0;

  static const _baseColor = AppColors.primary;

  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: AppColors.lightColorScheme,
      useMaterial3: true,
      fontFamily: 'PlusJakartaSans',
      textTheme: AppTypography.textTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _baseColor,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: _baseColor,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: _baseColor,
          side: const BorderSide(color: _baseColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
