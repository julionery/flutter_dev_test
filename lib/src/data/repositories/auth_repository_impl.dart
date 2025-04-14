import 'package:flutter_dev_test/generated/l10n.dart';
import 'package:flutter_dev_test/src/core/utils/exceptions/app_exceptions.dart';
import 'package:flutter_dev_test/src/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_dev_test/src/domain/entities/user_entity.dart';
import 'package:flutter_dev_test/src/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserEntity> login(String email, String password, {String? totpCode}) async {
    try {
      final userModel = await remoteDataSource.login(email, password, totpCode: totpCode);
      return userModel;
    } catch (e) {
      throw _handleException(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await remoteDataSource.logout();
    } catch (e) {
      throw _handleException(e);
    }
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    try {
      return await remoteDataSource.getCurrentUser();
    } catch (e) {
      throw _handleException(e);
    }
  }

  @override
  Future<String> verifyRecoveryCode(String email, String password, String code) async {
    try {
      return await remoteDataSource.verifyRecoveryCode(email, password, code);
    } catch (e) {
      throw _handleException(e);
    }
  }

  @override
  Future<void> resendRecoveryCode() async {
    await remoteDataSource.resendRecoveryCode();
  }

  /// Centralizes exception handling logic for both login and verification methods
  /// Returns the appropriate exception based on the error type
  Exception _handleException(dynamic e) {
    if (e is UnauthorizedException) {
      if (e.isInvalidTotp) {
        return InvalidTOTPException(S.current.errorLoginInvalidTotp);
      } else if (e.isInvalidCredentials) {
        return AppException(S.current.errorLoginInvalidCredentials);
      } else if (e.isInvalidRecoveryCode) {
        return AppException(S.current.errorLoginInvalidRecoveryCode);
      } else {
        return AppException(e.message);
      }
    } else if (e is NotFoundException) {
      if (e.isUserNotFound) {
        return AppException(S.current.errorLoginUserNotFound);
      } else {
        return AppException(e.message);
      }
    } else if (e is ServerException) {
      return AppException(e.message);
    } else {
      return AppException(S.current.errorUnknownError);
    }
  }
}
