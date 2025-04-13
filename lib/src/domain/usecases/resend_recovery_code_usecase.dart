import 'package:flutter_dev_test/src/domain/repositories/auth_repository.dart';

class ResendRecoveryCodeUseCase {
  final AuthRepository repository;

  ResendRecoveryCodeUseCase(this.repository);

  Future<void> call() async {
    return await repository.resendRecoveryCode();
  }
}
