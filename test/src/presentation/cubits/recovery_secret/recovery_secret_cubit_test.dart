import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_dev_test/src/core/utils/exceptions/app_exceptions.dart';
import 'package:flutter_dev_test/src/domain/usecases/resend_recovery_code_usecase.dart';
import 'package:flutter_dev_test/src/domain/usecases/verify_recovery_code_usecase.dart';
import 'package:flutter_dev_test/src/presentation/cubits/recovery_secret/recovery_secret_cubit.dart';
import 'package:flutter_dev_test/src/presentation/cubits/recovery_secret/recovery_secret_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([VerifyRecoveryCodeUseCase, ResendRecoveryCodeUseCase])
import 'recovery_secret_cubit_test.mocks.dart';

void main() {
  late RecoverySecretCubit recoverySecretCubit;
  late MockVerifyRecoveryCodeUseCase mockVerifyRecoveryCodeUseCase;
  late MockResendRecoveryCodeUseCase mockResendRecoveryCodeUseCase;

  // Test values
  const testEmail = 'test@example.com';
  const testPassword = 'password123';
  const testCode = '123456';
  const testInvalidCode = '12345'; // Less than 6 characters
  const testRecoveryToken = 'recovery_token_123';

  setUp(() {
    mockVerifyRecoveryCodeUseCase = MockVerifyRecoveryCodeUseCase();
    mockResendRecoveryCodeUseCase = MockResendRecoveryCodeUseCase();

    recoverySecretCubit = RecoverySecretCubit(
      (key) => switch (key) {
        (kKeyErrorRecoveryCodeInvalid) => 'Invalid recovery code (mock)',
        (kKeyErrorUnknownError) => 'Unknown error (mock)',
        String() => '',
      },
      verifyRecoveryCodeUseCase: mockVerifyRecoveryCodeUseCase,
      resendRecoveryCodeUseCase: mockResendRecoveryCodeUseCase,
      email: testEmail,
      password: testPassword,
    );
  });

  tearDown(() {
    recoverySecretCubit.close();
  });

  group('RecoverySecretCubit', () {
    test('initial state is correct', () {
      expect(recoverySecretCubit.state.status, equals(RecoverySecretStatus.initial));
      expect(recoverySecretCubit.state.email, equals(testEmail));
      expect(recoverySecretCubit.state.password, equals(testPassword));
      expect(recoverySecretCubit.state.code, isEmpty);
      expect(recoverySecretCubit.state.recoveryToken, isEmpty);
      expect(recoverySecretCubit.state.errorMessage, isNull);
      expect(recoverySecretCubit.state.canResendCode, isTrue);
      expect(recoverySecretCubit.state.resendCodeSuccess, isFalse);
    });

    blocTest<RecoverySecretCubit, RecoverySecretState>(
      'emits state with updated code when codeChanged is called',
      build: () => recoverySecretCubit,
      act: (cubit) => cubit.codeChanged(testCode),
      expect: () => [
        predicate<RecoverySecretState>((state) => state.code == testCode && state.status == RecoverySecretStatus.initial),
      ],
    );

    blocTest<RecoverySecretCubit, RecoverySecretState>(
      'emits state with updated email when emailChanged is called',
      build: () => recoverySecretCubit,
      act: (cubit) => cubit.emailChanged('new@example.com'),
      expect: () => [
        predicate<RecoverySecretState>((state) => state.email == 'new@example.com' && state.status == RecoverySecretStatus.initial),
      ],
    );

    blocTest<RecoverySecretCubit, RecoverySecretState>(
      'emits state with updated password when passwordChanged is called',
      build: () => recoverySecretCubit,
      act: (cubit) => cubit.passwordChanged('newpassword123'),
      expect: () => [
        predicate<RecoverySecretState>((state) => state.password == 'newpassword123' && state.status == RecoverySecretStatus.initial),
      ],
    );

    blocTest<RecoverySecretCubit, RecoverySecretState>(
      'emits failure state when submitCode is called with invalid code',
      build: () => recoverySecretCubit,
      act: (cubit) {
        cubit.codeChanged(testInvalidCode);
        return cubit.submitCode();
      },
      expect: () => [
        predicate<RecoverySecretState>((state) => state.code == testInvalidCode && state.status == RecoverySecretStatus.initial),
        predicate<RecoverySecretState>((state) => state.status == RecoverySecretStatus.failure && state.errorMessage != null),
      ],
    );

    blocTest<RecoverySecretCubit, RecoverySecretState>(
      'emits loading and success states when submitCode is successful',
      build: () {
        when(mockVerifyRecoveryCodeUseCase(testEmail, testPassword, testCode)).thenAnswer((_) async => testRecoveryToken);

        return recoverySecretCubit;
      },
      act: (cubit) {
        cubit.codeChanged(testCode);
        return cubit.submitCode();
      },
      expect: () => [
        predicate<RecoverySecretState>((state) => state.code == testCode && state.status == RecoverySecretStatus.initial),
        predicate<RecoverySecretState>((state) => state.status == RecoverySecretStatus.loading),
        predicate<RecoverySecretState>((state) => state.status == RecoverySecretStatus.success && state.recoveryToken == testRecoveryToken),
      ],
      verify: (_) {
        verify(mockVerifyRecoveryCodeUseCase(testEmail, testPassword, testCode)).called(1);
      },
    );

    blocTest<RecoverySecretCubit, RecoverySecretState>(
      'emits loading and failure states when submitCode fails with AppException',
      build: () {
        when(mockVerifyRecoveryCodeUseCase(testEmail, testPassword, testCode)).thenThrow(AppException('App exception error'));

        return recoverySecretCubit;
      },
      act: (cubit) {
        cubit.codeChanged(testCode);
        return cubit.submitCode();
      },
      expect: () => [
        predicate<RecoverySecretState>((state) => state.code == testCode && state.status == RecoverySecretStatus.initial),
        predicate<RecoverySecretState>((state) => state.status == RecoverySecretStatus.loading),
        predicate<RecoverySecretState>((state) => state.status == RecoverySecretStatus.failure && state.errorMessage == 'App exception error'),
      ],
    );

    blocTest<RecoverySecretCubit, RecoverySecretState>(
      'emits loading and failure states when submitCode fails with generic exception',
      build: () {
        when(mockVerifyRecoveryCodeUseCase(testEmail, testPassword, testCode)).thenThrow(Exception('Generic error'));

        return recoverySecretCubit;
      },
      act: (cubit) {
        cubit.codeChanged(testCode);
        return cubit.submitCode();
      },
      expect: () => [
        predicate<RecoverySecretState>((state) => state.code == testCode && state.status == RecoverySecretStatus.initial),
        predicate<RecoverySecretState>((state) => state.status == RecoverySecretStatus.loading),
        predicate<RecoverySecretState>((state) => state.status == RecoverySecretStatus.failure && state.errorMessage == 'Unknown error (mock)'),
      ],
    );

    blocTest<RecoverySecretCubit, RecoverySecretState>(
      'emits loading and success states when resendCode is successful',
      build: () {
        when(mockResendRecoveryCodeUseCase()).thenAnswer((_) async {});

        return recoverySecretCubit;
      },
      act: (cubit) => cubit.resendCode(),
      expect: () => [
        predicate<RecoverySecretState>((state) => state.status == RecoverySecretStatus.loading),
        predicate<RecoverySecretState>((state) => state.status == RecoverySecretStatus.initial && state.resendCodeSuccess == true),
      ],
      verify: (_) {
        verify(mockResendRecoveryCodeUseCase()).called(1);
      },
    );

    blocTest<RecoverySecretCubit, RecoverySecretState>(
      'emits loading and failure states when resendCode fails with AppException',
      build: () {
        when(mockResendRecoveryCodeUseCase()).thenThrow(AppException('App exception error'));

        return recoverySecretCubit;
      },
      act: (cubit) => cubit.resendCode(),
      expect: () => [
        predicate<RecoverySecretState>((state) => state.status == RecoverySecretStatus.loading),
        predicate<RecoverySecretState>((state) => state.status == RecoverySecretStatus.failure && state.errorMessage == 'App exception error'),
      ],
    );

    blocTest<RecoverySecretCubit, RecoverySecretState>(
      'emits loading and failure states when resendCode fails with generic exception',
      build: () {
        when(mockResendRecoveryCodeUseCase()).thenThrow(Exception('Generic error'));

        return recoverySecretCubit;
      },
      act: (cubit) => cubit.resendCode(),
      expect: () => [
        predicate<RecoverySecretState>((state) => state.status == RecoverySecretStatus.loading),
        predicate<RecoverySecretState>((state) => state.status == RecoverySecretStatus.failure && state.errorMessage == 'Unknown error (mock)'),
      ],
    );

    blocTest<RecoverySecretCubit, RecoverySecretState>(
      'emits initial state when resetState is called',
      build: () {
        recoverySecretCubit.codeChanged(testCode);
        recoverySecretCubit.emailChanged('new@example.com');
        recoverySecretCubit.passwordChanged('newpassword123');
        return recoverySecretCubit;
      },
      act: (cubit) => cubit.resetState(),
      expect: () => [
        const RecoverySecretState(),
      ],
    );
  });
}
