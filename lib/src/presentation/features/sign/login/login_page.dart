import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dev_test/generated/l10n.dart';
import 'package:flutter_dev_test/src/core/di/service_locator.dart';
import 'package:flutter_dev_test/src/core/foundations/spacing.dart';
import 'package:flutter_dev_test/src/core/foundations/themes.dart';
import 'package:flutter_dev_test/src/core/utils/constants/regex.dart';
import 'package:flutter_dev_test/src/presentation/cubits/login/login_cubit.dart';
import 'package:flutter_dev_test/src/presentation/cubits/login/login_state.dart';
import 'package:flutter_dev_test/src/presentation/features/main/main_page.dart';
import 'package:flutter_dev_test/src/presentation/features/sign/login/widgets/login_image.dart';
import 'package:flutter_dev_test/src/presentation/features/sign/recovery_secret/recovery_secret_page.dart';
import 'package:flutter_dev_test/src/presentation/widgets/buttons/app_elevated_button.dart';
import 'package:flutter_dev_test/src/presentation/widgets/snack_bars/app_snack_bar.dart';
import 'package:flutter_dev_test/src/presentation/widgets/text_field/app_text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final serviceLocator = ServiceLocator();

    return BlocProvider(
      create: (_) => LoginCubit(
        (key) => key == kKeyLoginErrorEmptyFields ? S.current.loginErrorEmptyFields : '',
        serviceLocator.loginUseCase,
      ),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) => previous.status != current.status || previous.needsRecoverySecret != current.needsRecoverySecret,
      listener: (context, state) {
        if (state.status == LoginStatus.success) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MainPage()),
          );
        } else if (state.status == LoginStatus.failure) {
          if (state.needsRecoverySecret) {
            final email = _emailController.text;
            final password = _passwordController.text;
            _navigateToRecoveryPage(email, password);
          } else {
            AppSnackBar.showError(context, state.errorMessage ?? S.of(context).errorLoginFailed);
          }
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: AppSpacing.$800),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LoginImage(),
                  const SizedBox(height: AppSpacing.$450),
                  Padding(
                    padding: const EdgeInsets.all(AppTheme.defaultPadding),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Email field
                          _buildEmailField(),
                          const SizedBox(height: AppSpacing.$125),
                          // Password field
                          _buildPasswordField(),
                          const SizedBox(height: AppSpacing.$250),
                          // Login button
                          _buildLoginButton(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: _buildForgotPasswordButton(),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return AppTextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          labelText: S.of(context).commonEmail,
          hintText: S.of(context).commonHintEmail,
          textInputAction: TextInputAction.next,
          onChanged: (value) {
            context.read<LoginCubit>().emailChanged(value);
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return S.of(context).errorValidatorEmptyEmail;
            }

            // Username admin can't use admin email, just for testing
            if (value == 'admin') return null;

            final emailRegExp = RegExp(kEmailRegEx);
            if (!emailRegExp.hasMatch(value)) {
              return S.of(context).errorValidatorInvalidEmail;
            }
            return null;
          },
        );
      },
    );
  }

  Widget _buildPasswordField() {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return AppTextField(
          controller: _passwordController,
          focusNode: _passwordFocusNode,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          labelText: S.of(context).commonPassword,
          hintText: S.of(context).commonHintPassword,
          onChanged: (value) {
            context.read<LoginCubit>().passwordChanged(value);
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return S.of(context).errorValidatorEmptyPassword;
            }
            if (value.length < 6) {
              return S.of(context).errorValidatorPasswordLeastSix;
            }
            return null;
          },
          onEditingComplete: _passwordController.text.isNotEmpty ? _doLogin : null,
        );
      },
    );
  }

  Widget _buildLoginButton() {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status || previous.isValid != current.isValid,
      builder: (context, state) {
        return AppElevatedButton(
          text: S.of(context).commonLogin,
          isLoading: state.status == LoginStatus.loading,
          onPressed: state.status == LoginStatus.loading ? null : _doLogin,
        );
      },
    );
  }

  Widget _buildForgotPasswordButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSpacing.$100),
          child: TextButton(
            onPressed: _doForgotPassword,
            child: Text(S.of(context).loginButtonForgotPassword),
          ),
        ),
      ],
    );
  }

  void _doLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      _passwordFocusNode.unfocus();
      context.read<LoginCubit>().login();
    }
  }

  void _doForgotPassword() {}

  Future<void> _navigateToRecoveryPage(String email, String password) async {
    final recoveryToken = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (context) => RecoverySecretPage(email: email, password: password),
      ),
    );

    if (recoveryToken != null && recoveryToken.isNotEmpty) {
      if (context.mounted) {
        context.read<LoginCubit>().setRecoveryToken(recoveryToken);
        _passwordFocusNode.unfocus();

        // Suggested improvements:
        // Show the successful snack bar.
        // Try logging in again without the user having to click
        //
        // AppSnackBar.showSuccess(context, S.of(context).recoveryCodeSuccessful);
        // context.read<LoginCubit>().login();
      }
    }
  }
}
