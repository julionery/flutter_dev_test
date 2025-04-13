import 'package:equatable/equatable.dart';

enum RecoverySecretStatus { initial, loading, success, failure }

class RecoverySecretState extends Equatable {
  final String code;
  final String email;
  final String password;
  final RecoverySecretStatus status;
  final String? errorMessage;
  final bool canResendCode;
  final bool resendCodeSuccess;

  const RecoverySecretState({
    this.code = '',
    this.email = '',
    this.password = '',
    this.status = RecoverySecretStatus.initial,
    this.errorMessage,
    this.canResendCode = true,
    this.resendCodeSuccess = false,
  });

  bool get isValid => code.length == 6;

  RecoverySecretState copyWith({
    String? code,
    String? email,
    String? password,
    RecoverySecretStatus? status,
    String? errorMessage,
    bool? canResendCode,
    bool? resendCodeSuccess,
  }) {
    return RecoverySecretState(
      code: code ?? this.code,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      canResendCode: canResendCode ?? this.canResendCode,
      resendCodeSuccess: resendCodeSuccess ?? this.resendCodeSuccess,
    );
  }

  @override
  List<Object?> get props => [code, email, password, status, errorMessage, canResendCode, resendCodeSuccess];
}
