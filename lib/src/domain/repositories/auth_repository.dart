import 'package:flutter_dev_test/src/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login(String email, String password, {String? totpCode});
  Future<void> logout();
  Future<UserEntity?> getCurrentUser();
  Future<String> verifyRecoveryCode(String email, String password, String code);
  Future<void> resendRecoveryCode();
}
