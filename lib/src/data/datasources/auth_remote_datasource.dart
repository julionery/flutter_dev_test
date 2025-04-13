import 'package:flutter_dev_test/src/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<void> logout();
  Future<UserModel?> getCurrentUser();
  Future<String> verifyRecoveryCode(String code);
  Future<void> resendRecoveryCode();
}
