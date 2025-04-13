import 'package:flutter/material.dart';
import 'package:flutter_dev_test/src/core/foundations/spacing.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    super.key,
    required this.onPressed,
    this.text = '',
    this.isLoading = false,
  });

  final VoidCallback? onPressed;

  final String text;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const SizedBox(
              height: AppSpacing.$250,
              width: AppSpacing.$250,
              child: CircularProgressIndicator(strokeWidth: AppSpacing.$25),
            )
          : Text(text),
    );
  }
}
