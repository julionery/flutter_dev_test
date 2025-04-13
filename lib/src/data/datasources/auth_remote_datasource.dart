import 'package:flutter_dev_test/src/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password, {String? totpCode});
  Future<void> logout();
  Future<UserModel?> getCurrentUser();
  Future<String> verifyRecoveryCode(String email, String password, String code);
  Future<void> resendRecoveryCode();
}
