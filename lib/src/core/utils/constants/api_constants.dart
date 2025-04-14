class ApiConstants {
  ApiConstants._();

  // Base URL
  static const String baseUrl = 'http://127.0.0.1:5000';

  // Endpoints
  static const String loginEndpoint = '/auth/login';
  static const String logoutEndpoint = '/auth/logout';
  static const String userEndpoint = '/auth/user';
  static const String recoverySecretEndpoint = '/auth/recovery-secret';
  static const String resendRecoveryCodeEndpoint = '/auth/resend-code';

  // Headers
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Timeout durations (in seconds)
  static const int connectionTimeout = 30;
  static const int receiveTimeout = 30;
}
