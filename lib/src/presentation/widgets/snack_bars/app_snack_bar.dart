import 'package:flutter/material.dart';
import 'package:flutter_dev_test/src/core/utils/constants/durations.dart';

class AppSnackBar {
  static void showError(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: kSnackBarDuration,
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
