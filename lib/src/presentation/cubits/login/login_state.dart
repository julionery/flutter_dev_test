import 'package:equatable/equatable.dart';
import 'package:flutter_dev_test/src/domain/entities/user_entity.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  final String email;
  final String password;
  final LoginStatus status;
  final String? errorMessage;
  final UserEntity? user;
  final bool needsRecoverySecret;

  const LoginState({
    this.email = '',
    this.password = '',
    this.status = LoginStatus.initial,
    this.errorMessage,
    this.user,
    this.needsRecoverySecret = false,
  });

  bool get isValid => email.isNotEmpty && password.isNotEmpty;

  LoginState copyWith({
    String? email,
    String? password,
    LoginStatus? status,
    String? errorMessage,
    UserEntity? user,
    bool? needsRecoverySecret,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
      needsRecoverySecret: needsRecoverySecret ?? this.needsRecoverySecret,
    );
  }

  @override
  List<Object?> get props => [email, password, status, errorMessage, user, needsRecoverySecret];
}
