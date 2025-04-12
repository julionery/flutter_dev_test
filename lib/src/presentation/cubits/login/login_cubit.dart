import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dev_test/generated/l10n.dart';
import 'package:flutter_dev_test/src/presentation/cubits/login/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  void emailChanged(String value) {
    emit(state.copyWith(email: value));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value));
  }

  Future<void> login() async {
    if (!state.isValid) {
      emit(state.copyWith(
        errorMessage: S.current.loginErrorEmptyFields,
        status: LoginStatus.failure,
      ));
      return;
    }

    emit(state.copyWith(status: LoginStatus.loading));

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    try {
      // For demo purposes, consider any email ending with @test.com and password "password" as valid
      if (state.email.endsWith('@test.com') && state.password == 'password') {
        emit(state.copyWith(status: LoginStatus.success));
      } else {
        emit(state.copyWith(
          status: LoginStatus.failure,
          errorMessage: S.current.errorLoginInvalidCredentials,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  void resetState() {
    emit(const LoginState());
  }
}
