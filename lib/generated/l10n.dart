// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Dev Flutter Test`
  String get appName {
    return Intl.message(
      'Dev Flutter Test',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Login`
  String get commonLogin {
    return Intl.message('Login', name: 'commonLogin', desc: '', args: []);
  }

  /// `Password`
  String get commonPassword {
    return Intl.message('Password', name: 'commonPassword', desc: '', args: []);
  }

  /// `E-mail`
  String get commonEmail {
    return Intl.message('E-mail', name: 'commonEmail', desc: '', args: []);
  }

  /// `Enter your email`
  String get commonHintEmail {
    return Intl.message(
      'Enter your email',
      name: 'commonHintEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get commonHintPassword {
    return Intl.message(
      'Enter your password',
      name: 'commonHintPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email`
  String get errorValidatorEmptyEmail {
    return Intl.message(
      'Please enter your email',
      name: 'errorValidatorEmptyEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get errorValidatorInvalidEmail {
    return Intl.message(
      'Please enter a valid email',
      name: 'errorValidatorInvalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get errorValidatorEmptyPassword {
    return Intl.message(
      'Please enter your password',
      name: 'errorValidatorEmptyPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get errorValidatorPasswordLeastSix {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'errorValidatorPasswordLeastSix',
      desc: '',
      args: [],
    );
  }

  /// `Invalid credentials`
  String get errorLoginInvalidCredentials {
    return Intl.message(
      'Invalid credentials',
      name: 'errorLoginInvalidCredentials',
      desc: '',
      args: [],
    );
  }

  /// `Invalid verification code`
  String get errorLoginInvalidTotp {
    return Intl.message(
      'Invalid verification code',
      name: 'errorLoginInvalidTotp',
      desc: '',
      args: [],
    );
  }

  /// `Invalid recovery code`
  String get errorLoginInvalidRecoveryCode {
    return Intl.message(
      'Invalid recovery code',
      name: 'errorLoginInvalidRecoveryCode',
      desc: '',
      args: [],
    );
  }

  /// `User not found`
  String get errorLoginUserNotFound {
    return Intl.message(
      'User not found',
      name: 'errorLoginUserNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Login failed`
  String get errorLoginFailed {
    return Intl.message(
      'Login failed',
      name: 'errorLoginFailed',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password`
  String get loginButtonForgotPassword {
    return Intl.message(
      'Forgot password',
      name: 'loginButtonForgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please fill in all fields`
  String get loginErrorEmptyFields {
    return Intl.message(
      'Please fill in all fields',
      name: 'loginErrorEmptyFields',
      desc: '',
      args: [],
    );
  }

  /// `Failed to connect to server`
  String get errorFailedToConnectToServer {
    return Intl.message(
      'Failed to connect to server',
      name: 'errorFailedToConnectToServer',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error`
  String get errorUnknownError {
    return Intl.message(
      'Unknown error',
      name: 'errorUnknownError',
      desc: '',
      args: [],
    );
  }

  /// `I didn't receive the code`
  String get resendCodeButtonText {
    return Intl.message(
      'I didn\'t receive the code',
      name: 'resendCodeButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get commonConfirm {
    return Intl.message('Confirm', name: 'commonConfirm', desc: '', args: []);
  }

  /// `Verification`
  String get pageRecoverySecretTitle {
    return Intl.message(
      'Verification',
      name: 'pageRecoverySecretTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter the code you were sent:`
  String get pageRecoverySecretDescription {
    return Intl.message(
      'Enter the code you were sent:',
      name: 'pageRecoverySecretDescription',
      desc: '',
      args: [],
    );
  }

  /// `Code resent successfully!`
  String get recoveryCodeResent {
    return Intl.message(
      'Code resent successfully!',
      name: 'recoveryCodeResent',
      desc: '',
      args: [],
    );
  }

  /// `Invalid verification code`
  String get errorRecoveryCodeInvalid {
    return Intl.message(
      'Invalid verification code',
      name: 'errorRecoveryCodeInvalid',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'pt', countryCode: 'BR'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
