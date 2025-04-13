import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dev_test/generated/l10n.dart';
import 'package:flutter_dev_test/src/core/di/service_locator.dart';
import 'package:flutter_dev_test/src/core/foundations/colors.dart';
import 'package:flutter_dev_test/src/core/foundations/spacing.dart';
import 'package:flutter_dev_test/src/core/foundations/typography.dart';
import 'package:flutter_dev_test/src/presentation/cubits/recovery_secret/recovery_secret_cubit.dart';
import 'package:flutter_dev_test/src/presentation/cubits/recovery_secret/recovery_secret_state.dart';
import 'package:flutter_dev_test/src/presentation/features/sign/recovery_secret/widgets/resend_code_button.dart';
import 'package:flutter_dev_test/src/presentation/widgets/buttons/app_back_button.dart';
import 'package:flutter_dev_test/src/presentation/widgets/buttons/app_elevated_button.dart';
import 'package:flutter_dev_test/src/presentation/widgets/snack_bars/app_snack_bar.dart';
import 'package:flutter_dev_test/src/presentation/widgets/text_field/app_otp_text_field.dart';

class RecoverySecretPage extends StatelessWidget {
  final String email;
  final String password;
  
  const RecoverySecretPage({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    final serviceLocator = ServiceLocator();
    return BlocProvider(
      create: (_) => serviceLocator.recoverySecretCubit
        ..emailChanged(email)
        ..passwordChanged(password),
      child: const RecoverySecretView(),
    );
  }
}

class RecoverySecretView extends StatefulWidget {
  const RecoverySecretView({super.key});

  @override
  State<RecoverySecretView> createState() => _RecoverySecretViewState();
}

class _RecoverySecretViewState extends State<RecoverySecretView> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocListener<RecoverySecretCubit, RecoverySecretState>(
      listenWhen: (previous, current) => previous.status != current.status || previous.resendCodeSuccess != current.resendCodeSuccess,
      listener: (context, state) {
        if (state.status == RecoverySecretStatus.success) {
          Navigator.of(context).pop();
        } else if (state.status == RecoverySecretStatus.failure) {
          AppSnackBar.showError(context, state.errorMessage ?? S.of(context).errorUnknownError);
        }

        if (state.resendCodeSuccess) {
          AppSnackBar.showSuccess(context, S.of(context).recoveryCodeResent);
          context.read<RecoverySecretCubit>().resetState();
        }
      },
      child: Scaffold(
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
                            _buildOTPTextField(),
                            const SizedBox(height: AppSpacing.$400),
                            _buildButtonConfirm(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.$500),
              _buildResendCodeButton(),
              const SizedBox(height: AppSpacing.$250),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonConfirm() {
    return BlocBuilder<RecoverySecretCubit, RecoverySecretState>(
      buildWhen: (previous, current) => previous.status != current.status || previous.isValid != current.isValid,
      builder: (context, state) {
        return AppElevatedButton(
          text: S.of(context).commonConfirm,
          isLoading: state.status == RecoverySecretStatus.loading,
          onPressed: state.isValid ? _submitRecoveryCode : null,
        );
      },
    );
  }

  Widget _buildOTPTextField() {
    return BlocBuilder<RecoverySecretCubit, RecoverySecretState>(
      buildWhen: (previous, current) => previous.code != current.code || previous.status != current.status,
      builder: (context, state) {
        return AppOTPTextField(
          enabled: state.status != RecoverySecretStatus.loading,
          value: state.code,
          onChanged: (value) {
            context.read<RecoverySecretCubit>().codeChanged(value);
            if (value.length == 6) {
              FocusScope.of(context).unfocus();
              _submitRecoveryCode();
            }
          },
        );
      },
    );
  }

  Widget _buildResendCodeButton() {
    return BlocBuilder<RecoverySecretCubit, RecoverySecretState>(
      buildWhen: (previous, current) => previous.canResendCode != current.canResendCode,
      builder: (context, state) {
        final bool isEnabled = state.canResendCode;
        return ResendCodeButton(
          enabled: isEnabled,
          onPressed: () => context.read<RecoverySecretCubit>().resendCode(),
        );
      },
    );
  }

  void _submitRecoveryCode() {
    FocusScope.of(context).unfocus();
    context.read<RecoverySecretCubit>().submitCode();
  }
}
