import 'package:flutter/material.dart';
import 'package:flutter_dev_test/src/core/foundations/colors.dart';
import 'package:flutter_dev_test/src/core/utils/constants/durations.dart';

class AppSnackBar {
  static void showError(BuildContext context, String message) {
    _showSnackBar(context, message);
  }

  static void showDanger(BuildContext context, String message) {
    _showSnackBar(context, message, color: AppColors.error);
  }

  static void showInfo(BuildContext context, String message) {
    _showSnackBar(context, message, color: AppColors.info);
  }

  static void showSuccess(BuildContext context, String message) {
    _showSnackBar(context, message, color: AppColors.success);
  }

  static void showWarning(BuildContext context, String message) {
    _showSnackBar(context, message, color: AppColors.warning);
  }

  static void showCustom(BuildContext context, String message, Color color) {
    _showSnackBar(context, message, color: color);
  }

  static void _showSnackBar(BuildContext context, String message, {Color? color}) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: kSnackBarDuration,
      backgroundColor: color,
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
