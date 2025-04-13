import 'package:flutter_dev_test/generated/l10n.dart';
import 'package:flutter_dev_test/src/core/utils/exceptions/app_exceptions.dart';
import 'package:flutter_dev_test/src/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_dev_test/src/domain/entities/user_entity.dart';
import 'package:flutter_dev_test/src/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserEntity> login(String email, String password) async {
    try {
      final userModel = await remoteDataSource.login(email, password);
      return userModel;
    } on UnauthorizedException catch (e) {
      if (e.isInvalidTotp) {
        throw InvalidTOTPException(S.current.errorLoginInvalidTotp);
      } else if (e.isInvalidCredentials) {
        throw AppException(S.current.errorLoginInvalidCredentials);
      } else if (e.isInvalidRecoveryCode) {
        throw AppException(S.current.errorLoginInvalidRecoveryCode);
      } else {
        throw AppException(e.message);
      }
    } on NotFoundException catch (e) {
      if (e.isUserNotFound) {
        throw AppException(S.current.errorLoginUserNotFound);
      } else {
        throw AppException(e.message);
      }
    } on ServerException catch (e) {
      throw AppException(e.message);
    } catch (e) {
      throw AppException('${S.current.errorLoginFailed}: ${e.toString()}');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await remoteDataSource.logout();
    } catch (e) {
      throw Exception('Failed to logout: ${e.toString()}');
    }
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    try {
      return await remoteDataSource.getCurrentUser();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<String> verifyRecoveryCode(String code) async {
    try {
      return await remoteDataSource.verifyRecoveryCode(code);
    } on UnauthorizedException catch (e) {
      if (e.isInvalidTotp) {
        throw InvalidTOTPException(S.current.errorLoginInvalidTotp);
      } else if (e.isInvalidCredentials) {
        throw AppException(S.current.errorLoginInvalidCredentials);
      } else if (e.isInvalidRecoveryCode) {
        throw AppException(S.current.errorLoginInvalidRecoveryCode);
      } else {
        throw AppException(e.message);
      }
    } on NotFoundException catch (e) {
      if (e.isUserNotFound) {
        throw AppException(S.current.errorLoginUserNotFound);
      } else {
        throw AppException(e.message);
      }
    } on ServerException catch (e) {
      throw AppException(e.message);
    } catch (e) {
      throw AppException(S.current.errorUnknownError);
    }
  }

  @override
  Future<void> resendRecoveryCode() async {
    await remoteDataSource.resendRecoveryCode();
  }
}
