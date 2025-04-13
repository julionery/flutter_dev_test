import 'package:flutter/material.dart';
import 'package:flutter_dev_test/generated/l10n.dart';
import 'package:flutter_dev_test/src/core/foundations/colors.dart';
import 'package:flutter_dev_test/src/core/foundations/spacing.dart';
import 'package:flutter_dev_test/src/core/foundations/typography.dart';
import 'package:flutter_dev_test/src/presentation/features/sign/recovery_secret/widgets/resend_code_button.dart';
import 'package:flutter_dev_test/src/presentation/widgets/buttons/app_back_button.dart';
import 'package:flutter_dev_test/src/presentation/widgets/buttons/app_elevated_button.dart';
import 'package:flutter_dev_test/src/presentation/widgets/text_field/app_otp_text_field.dart';

class RecoverySecretPage extends StatefulWidget {
  const RecoverySecretPage({super.key});

  @override
  State<RecoverySecretPage> createState() => _RecoverySecretPageState();
}

class _RecoverySecretPageState extends State<RecoverySecretPage> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppBackButton(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.$250),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      S.of(context).pageRecoverySecretTitle,
                      style: AppTypography.titleLarge.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.$75),
                    Text(
                      S.of(context).pageRecoverySecretDescription,
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.$900),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          AppOTPTextField(),
                          const SizedBox(height: AppSpacing.$400),
                          AppElevatedButton(
                            text: S.of(context).commonConfirm,
                            onPressed: _submitRecoveryCode,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.$500),
            ResendCodeButton(),
            const SizedBox(height: AppSpacing.$250),
          ],
        ),
      ),
    );
  }

  void _submitRecoveryCode() {}
}
