import 'package:flutter/material.dart';
import 'package:flutter_dev_test/generated/l10n.dart';
import 'package:flutter_dev_test/src/core/foundations/spacing.dart';
import 'package:flutter_dev_test/src/core/utils/constants/image_paths.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResendCodeButton extends StatelessWidget {
  const ResendCodeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            ImagePaths.messageQuestion,
            width: AppSpacing.$300,
            height: AppSpacing.$300,
          ),
          SizedBox(width: AppSpacing.$100),
          Text(S.of(context).resendCodeButtonText),
        ],
      ),
      onPressed: () {},
    );
  }
}
