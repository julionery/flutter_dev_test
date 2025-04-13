import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dev_test/generated/l10n.dart';
import 'package:flutter_dev_test/src/presentation/cubits/recovery_secret/recovery_secret_state.dart';

class RecoverySecretCubit extends Cubit<RecoverySecretState> {
  RecoverySecretCubit() : super(const RecoverySecretState());

  void codeChanged(String value) {
    emit(state.copyWith(code: value));
  }

  Future<void> submitCode() async {
    if (!state.isValid) {
      emit(state.copyWith(
        errorMessage: S.current.errorUnknownError,
        status: RecoverySecretStatus.failure,
      ));
      return;
    }

    emit(state.copyWith(status: RecoverySecretStatus.loading));

    try {
      await Future.delayed(const Duration(seconds: 5));
      emit(state.copyWith(status: RecoverySecretStatus.failure));
    } catch (e) {
      emit(state.copyWith(
        status: RecoverySecretStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> resendCode() async {}

  void resetState() {
    emit(const RecoverySecretState());
  }
}
