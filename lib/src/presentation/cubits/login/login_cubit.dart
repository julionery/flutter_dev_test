import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dev_test/src/core/utils/exceptions/app_exceptions.dart';
import 'package:flutter_dev_test/src/domain/usecases/login_usecase.dart';
import 'package:flutter_dev_test/src/presentation/cubits/login/login_state.dart';

const kKeyLoginErrorEmptyFields = 'loginErrorEmptyFields';

class LoginCubit extends Cubit<LoginState> {
  final String Function(String key) _translate;

  final LoginUseCase _loginUseCase;

  LoginCubit(this._translate, this._loginUseCase) : super(const LoginState());

  void emailChanged(String value) {
    emit(state.copyWith(email: value));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value));
  }

  void setRecoveryToken(String token) {
    emit(state.copyWith(recoveryToken: token));
  }

  Future<void> login() async {
    if (!state.isValid) {
      emit(state.copyWith(
        errorMessage: _translate(kKeyLoginErrorEmptyFields),
        status: LoginStatus.failure,
      ));
      return;
    }

    emit(state.copyWith(status: LoginStatus.loading));

    try {
      final user = await _loginUseCase.execute(
        state.email,
        state.password,
        recoveryToken: state.recoveryToken,
      );
      emit(state.copyWith(
        status: LoginStatus.success,
        user: user,
        recoveryToken: null,
      ));
    } catch (e) {
      bool needsRecovery = e is InvalidTOTPException;
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: e.toString(),
        needsRecoverySecret: needsRecovery,
      ));
    }
  }

  void resetState() {
    emit(const LoginState());
  }
}
