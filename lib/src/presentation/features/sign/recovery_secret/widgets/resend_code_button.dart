import 'package:flutter/material.dart';
import 'package:flutter_dev_test/generated/l10n.dart';
import 'package:flutter_dev_test/src/core/foundations/colors.dart';
import 'package:flutter_dev_test/src/core/foundations/spacing.dart';
import 'package:flutter_dev_test/src/core/utils/constants/image_paths.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResendCodeButton extends StatelessWidget {
  const ResendCodeButton({
    super.key,
    this.enabled = true,
    this.onPressed,
  });

  final bool enabled;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: enabled ? onPressed : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            ImagePaths.messageQuestion,
            width: AppSpacing.$300,
            height: AppSpacing.$300,
            colorFilter: ColorFilter.mode(
              enabled ? AppColors.primary : AppColors.disabled,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: AppSpacing.$100),
          Text(
            S.of(context).resendCodeButtonText,
            style: TextStyle(
              color: enabled ? AppColors.primary : AppColors.disabled,
            ),
          ),
        ],
      ),
    );
  }
}
