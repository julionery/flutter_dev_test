import 'package:flutter/material.dart';

/// This class contains all the colors used in the application.
/// It provides easy access to predefined color schemes.
class AppColors {
  AppColors._();

  // Brand Colors
  static const Color primary = Color(0xFF7A5D3E);
  static const Color secondary = Color(0xFF9496AA);

  // Text Colors
  static const Color textPrimary = Color(0xFF212229);
  static const Color textSecondary = Color(0xFF9496AA);
  static const Color textOnBackground = Color(0xFF494A57);
  static const Color textInvert = Color(0xFFFFFFFF);

  // Background Colors
  static const Color background = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFF8F8FA);
  static const Color surface = Color(0xFFFFFFFF);

  // State Colors
  static const Color error = Color(0xFFB00020);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color info = Color(0xFF2196F3);

  // Common Colors
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color transparent = Color(0x00000000);

  // Utility Shades - Primary color variations
  static Color primaryLight = primary.withOpacity(0.8);
  static Color primaryLighter = primary.withOpacity(0.5);
  static Color primaryLightest = primary.withOpacity(0.2);

  // Utility Shades - Text colors with opacity
  static Color textPrimaryLight = textPrimary.withOpacity(0.8);
  static Color textSecondaryLight = textSecondary.withOpacity(0.8);

  // Material color swatch for primary color
  static const MaterialColor primarySwatch = MaterialColor(
    0xFF7A5D3E,
    <int, Color>{
      50: Color(0xFFF3F0EC),
      100: Color(0xFFE2D9CF),
      200: Color(0xFFCFC0AF),
      300: Color(0xFFBBA78F),
      400: Color(0xFFAC9577),
      500: Color(0xFF9C8462),
      600: Color(0xFF8A7357),
      700: Color(0xFF7A5D3E),
      800: Color(0xFF694E34),
      900: Color(0xFF58402A),
    },
  );

  // Color schemes for light and dark themes
  static ColorScheme get lightColorScheme => ColorScheme(
        primary: primary,
        primaryContainer: primaryLight,
        secondary: secondary,
        secondaryContainer: secondary.withOpacity(0.2),
        surface: surface,
        error: error,
        onPrimary: white,
        onSecondary: white,
        onSurface: textPrimary,
        onError: white,
        brightness: Brightness.light,
      );
}
