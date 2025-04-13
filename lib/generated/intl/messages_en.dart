// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "appName": MessageLookupByLibrary.simpleMessage("Dev Flutter Test"),
    "commonConfirm": MessageLookupByLibrary.simpleMessage("Confirm"),
    "commonEmail": MessageLookupByLibrary.simpleMessage("E-mail"),
    "commonHintEmail": MessageLookupByLibrary.simpleMessage("Enter your email"),
    "commonHintPassword": MessageLookupByLibrary.simpleMessage(
      "Enter your password",
    ),
    "commonLogin": MessageLookupByLibrary.simpleMessage("Login"),
    "commonPassword": MessageLookupByLibrary.simpleMessage("Password"),
    "errorFailedToConnectToServer": MessageLookupByLibrary.simpleMessage(
      "Failed to connect to server",
    ),
    "errorLoginFailed": MessageLookupByLibrary.simpleMessage("Login failed"),
    "errorLoginInvalidCredentials": MessageLookupByLibrary.simpleMessage(
      "Invalid credentials",
    ),
    "errorLoginInvalidRecoveryCode": MessageLookupByLibrary.simpleMessage(
      "Invalid recovery code",
    ),
    "errorLoginInvalidTotp": MessageLookupByLibrary.simpleMessage(
      "Invalid verification code",
    ),
    "errorLoginUserNotFound": MessageLookupByLibrary.simpleMessage(
      "User not found",
    ),
    "errorRecoveryCodeInvalid": MessageLookupByLibrary.simpleMessage(
      "Invalid verification code",
    ),
    "errorUnknownError": MessageLookupByLibrary.simpleMessage("Unknown error"),
    "errorValidatorEmptyEmail": MessageLookupByLibrary.simpleMessage(
      "Please enter your email",
    ),
    "errorValidatorEmptyPassword": MessageLookupByLibrary.simpleMessage(
      "Please enter your password",
    ),
    "errorValidatorInvalidEmail": MessageLookupByLibrary.simpleMessage(
      "Please enter a valid email",
    ),
    "errorValidatorPasswordLeastSix": MessageLookupByLibrary.simpleMessage(
      "Password must be at least 6 characters",
    ),
    "home": MessageLookupByLibrary.simpleMessage("Home"),
    "loginButtonForgotPassword": MessageLookupByLibrary.simpleMessage(
      "Forgot password",
    ),
    "loginErrorEmptyFields": MessageLookupByLibrary.simpleMessage(
      "Please fill in all fields",
    ),
    "pageRecoverySecretDescription": MessageLookupByLibrary.simpleMessage(
      "Enter the code you were sent:",
    ),
    "pageRecoverySecretTitle": MessageLookupByLibrary.simpleMessage(
      "Verification",
    ),
    "profile": MessageLookupByLibrary.simpleMessage("Profile"),
    "recoveryCodeResent": MessageLookupByLibrary.simpleMessage(
      "Code resent successfully!",
    ),
    "recoveryCodeSuccessful": MessageLookupByLibrary.simpleMessage(
      "Recovery code successful",
    ),
    "resendCodeButtonText": MessageLookupByLibrary.simpleMessage(
      "I didn\'t receive the code",
    ),
  };
}
