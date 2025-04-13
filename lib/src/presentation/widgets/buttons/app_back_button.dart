import 'package:flutter/material.dart';
import 'package:flutter_dev_test/src/core/foundations/colors.dart';
import 'package:flutter_dev_test/src/core/foundations/spacing.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (!Navigator.of(context).canPop()) return SizedBox(height: AppSpacing.$500);
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.$75, vertical: AppSpacing.$150),
        child: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: Icon(
            Icons.chevron_left,
            size: AppSpacing.$300,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
