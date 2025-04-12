/// Base exception class for the application
class AppException implements Exception {
  final String message;

  AppException(this.message);

  @override
  String toString() => message;
}

/// Exception that should be thrown when a server returns an error
class ServerException extends AppException {
  ServerException(super.message);
}

/// Exception that should be thrown when the user is not authorized
class UnauthorizedException extends AppException {
  final String? errorCode;

  UnauthorizedException(super.message, {this.errorCode});

  bool get isInvalidTotp => errorCode == 'INVALID_TOTP';
  bool get isInvalidCredentials => errorCode == 'INVALID_CREDENTIALS';
  bool get isInvalidRecoveryCode => errorCode == 'INVALID_RECOVERY_CODE';
}

/// Exception that should be thrown when a resource is not found
class NotFoundException extends AppException {
  final String? errorCode;

  NotFoundException(super.message, {this.errorCode});

  bool get isUserNotFound => errorCode == 'USER_NOT_FOUND';
}

/// Exception that should be thrown when there's a network problem
class NetworkException extends AppException {
  NetworkException(super.message);
}

/// Exception that should be thrown when trying to access cache without data
class CacheException extends AppException {
  CacheException(super.message);
}
