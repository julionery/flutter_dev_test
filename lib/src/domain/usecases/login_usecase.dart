import 'package:flutter_dev_test/src/core/utils/totp/totp_utils.dart';
import 'package:flutter_dev_test/src/domain/entities/user_entity.dart';
import 'package:flutter_dev_test/src/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<UserEntity> execute(String email, String password, {String? recoveryToken}) async {
    String? totpCode;
    
    if (recoveryToken != null && recoveryToken.isNotEmpty) {
      totpCode = TOTPUtils.generateTOTP(recoveryToken);
    }
    
    return await repository.login(email, password, totpCode: totpCode);
  }
}
