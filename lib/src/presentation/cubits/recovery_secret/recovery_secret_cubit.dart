import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dev_test/src/core/utils/exceptions/app_exceptions.dart';
import 'package:flutter_dev_test/src/domain/usecases/resend_recovery_code_usecase.dart';
import 'package:flutter_dev_test/src/domain/usecases/verify_recovery_code_usecase.dart';
import 'package:flutter_dev_test/src/presentation/cubits/recovery_secret/recovery_secret_state.dart';

const kKeyErrorRecoveryCodeInvalid = 'errorRecoveryCodeInvalid';
const kKeyErrorUnknownError = 'errorUnknownError';

class RecoverySecretCubit extends Cubit<RecoverySecretState> {
  final String Function(String key) _translate;

  final VerifyRecoveryCodeUseCase _verifyRecoveryCodeUseCase;
  final ResendRecoveryCodeUseCase _resendRecoveryCodeUseCase;

  RecoverySecretCubit(
    this._translate, {
    required VerifyRecoveryCodeUseCase verifyRecoveryCodeUseCase,
    required ResendRecoveryCodeUseCase resendRecoveryCodeUseCase,
    String email = '',
    String password = '',
  })  : _verifyRecoveryCodeUseCase = verifyRecoveryCodeUseCase,
        _resendRecoveryCodeUseCase = resendRecoveryCodeUseCase,
        super(RecoverySecretState(email: email, password: password));

  void codeChanged(String value) {
    emit(state.copyWith(code: value));
  }

  void emailChanged(String value) {
    emit(state.copyWith(email: value));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value));
  }

  Future<void> submitCode() async {
    if (!state.isValid) {
      emit(state.copyWith(
        errorMessage: _translate(kKeyErrorRecoveryCodeInvalid),
        status: RecoverySecretStatus.failure,
      ));
      return;
    }

    emit(state.copyWith(status: RecoverySecretStatus.loading));

    try {
      final String recoveryToken = await _verifyRecoveryCodeUseCase(state.email, state.password, state.code);
      emit(state.copyWith(
        status: RecoverySecretStatus.success,
        recoveryToken: recoveryToken,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: RecoverySecretStatus.failure,
        errorMessage: e.message,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: RecoverySecretStatus.failure,
        errorMessage: _translate(kKeyErrorUnknownError),
      ));
    }
  }

  Future<void> resendCode() async {
    emit(state.copyWith(status: RecoverySecretStatus.loading));

    try {
      await _resendRecoveryCodeUseCase();
      emit(state.copyWith(
        status: RecoverySecretStatus.initial,
        resendCodeSuccess: true,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: RecoverySecretStatus.failure,
        errorMessage: e.message,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: RecoverySecretStatus.failure,
        errorMessage: _translate(kKeyErrorUnknownError),
      ));
    }
  }

  void resetState() {
    emit(const RecoverySecretState());
  }
}
