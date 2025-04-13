import 'package:otp/otp.dart';

/// A utility class for TOTP (Time-based One-Time Password) operations.
class TOTPUtils {
  /// Generates a TOTP code using the provided secret.
  ///
  /// The code is generated using the current time, with a 30-second interval,
  /// SHA1 algorithm, and following Google's TOTP format.
  ///
  /// [secret] - The secret key used to generate the TOTP code
  /// Returns the generated TOTP code as a string
  static String generateTOTP(String secret) {
    return OTP.generateTOTPCodeString(
      secret,
      DateTime.now().millisecondsSinceEpoch,
      interval: 30,
      algorithm: Algorithm.SHA1,
      isGoogle: true,
    );
  }
}
