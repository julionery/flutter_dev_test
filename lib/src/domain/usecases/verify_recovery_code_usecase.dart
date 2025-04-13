import 'package:flutter_dev_test/src/domain/repositories/auth_repository.dart';

class VerifyRecoveryCodeUseCase {
  final AuthRepository repository;

  VerifyRecoveryCodeUseCase(this.repository);

  Future<String> call(String email, String password, String code) async {
    return await repository.verifyRecoveryCode(email, password, code);
  }
}
