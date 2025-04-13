import 'package:equatable/equatable.dart';

enum RecoverySecretStatus { initial, loading, success, failure }

class RecoverySecretState extends Equatable {
  final String code;
  final RecoverySecretStatus status;
  final String? errorMessage;
  final bool canResendCode;

  const RecoverySecretState({
    this.code = '',
    this.status = RecoverySecretStatus.initial,
    this.errorMessage,
    this.canResendCode = true,
  });

  bool get isValid => code.length == 6;

  RecoverySecretState copyWith({
    String? code,
    RecoverySecretStatus? status,
    String? errorMessage,
    bool? canResendCode,
  }) {
    return RecoverySecretState(
      code: code ?? this.code,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      canResendCode: canResendCode ?? this.canResendCode,
    );
  }

  @override
  List<Object?> get props => [code, status, errorMessage, canResendCode];
}
