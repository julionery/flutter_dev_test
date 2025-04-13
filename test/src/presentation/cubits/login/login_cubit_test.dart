import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_dev_test/src/core/utils/exceptions/app_exceptions.dart';
import 'package:flutter_dev_test/src/domain/entities/user_entity.dart';
import 'package:flutter_dev_test/src/domain/usecases/login_usecase.dart';
import 'package:flutter_dev_test/src/presentation/cubits/login/login_cubit.dart';
import 'package:flutter_dev_test/src/presentation/cubits/login/login_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([LoginUseCase])
import 'login_cubit_test.mocks.dart';

void main() {
  group('LoginCubit', () {
    late LoginCubit loginCubit;
    late MockLoginUseCase mockLoginUseCase;

    const testEmail = 'test@example.com';
    const testPassword = 'password123';
    const testRecoveryToken = 'recovery_token_123';
    final testUser = UserEntity(
      id: '1',
      name: 'Test User',
      email: testEmail,
    );

    setUp(() {
      mockLoginUseCase = MockLoginUseCase();
      loginCubit = LoginCubit((_) => 'Invalid credentials (mock)', mockLoginUseCase);
    });

    tearDown(() {
      loginCubit.close();
    });

    test('initial state is LoginState with status initial', () {
      expect(loginCubit.state.status, equals(LoginStatus.initial));
      expect(loginCubit.state.email, isEmpty);
      expect(loginCubit.state.password, isEmpty);
      expect(loginCubit.state.recoveryToken, isNull);
      expect(loginCubit.state.user, isNull);
      expect(loginCubit.state.needsRecoverySecret, isFalse);
      expect(loginCubit.state.errorMessage, isNull);
    });

    blocTest<LoginCubit, LoginState>(
      'emits state with email when emailChanged is called',
      build: () => loginCubit,
      act: (cubit) => cubit.emailChanged(testEmail),
      expect: () => [
        predicate<LoginState>((state) => state.email == testEmail && state.status == LoginStatus.initial),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits state with password when passwordChanged is called',
      build: () => loginCubit,
      act: (cubit) => cubit.passwordChanged(testPassword),
      expect: () => [
        predicate<LoginState>((state) => state.password == testPassword && state.status == LoginStatus.initial),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits state with recoveryToken when setRecoveryToken is called',
      build: () => loginCubit,
      act: (cubit) => cubit.setRecoveryToken(testRecoveryToken),
      expect: () => [
        predicate<LoginState>((state) => state.recoveryToken == testRecoveryToken && state.status == LoginStatus.initial),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits failure state when login is called with empty fields',
      build: () => loginCubit,
      act: (cubit) => cubit.login(),
      expect: () => [
        predicate<LoginState>((state) => state.status == LoginStatus.failure && state.errorMessage != null),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits loading and success states when login is successful',
      build: () {
        when(mockLoginUseCase.execute(testEmail, testPassword, recoveryToken: null)).thenAnswer((_) async => testUser);

        loginCubit.emailChanged(testEmail);
        loginCubit.passwordChanged(testPassword);
        return loginCubit;
      },
      act: (cubit) => cubit.login(),
      expect: () => [
        predicate<LoginState>((state) => state.status == LoginStatus.loading),
        predicate<LoginState>((state) => state.status == LoginStatus.success && state.user == testUser),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits loading and failure states when login fails with regular exception',
      build: () {
        when(mockLoginUseCase.execute(testEmail, testPassword, recoveryToken: null)).thenThrow(Exception('Login failed'));

        loginCubit.emailChanged(testEmail);
        loginCubit.passwordChanged(testPassword);
        return loginCubit;
      },
      act: (cubit) => cubit.login(),
      expect: () => [
        predicate<LoginState>((state) => state.status == LoginStatus.loading),
        predicate<LoginState>((state) => state.status == LoginStatus.failure && state.errorMessage != null && state.needsRecoverySecret == false),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits loading and failure states with needsRecoverySecret when InvalidTOTPException occurs',
      build: () {
        when(mockLoginUseCase.execute(testEmail, testPassword, recoveryToken: null)).thenThrow(InvalidTOTPException('Invalid TOTP code'));

        loginCubit.emailChanged(testEmail);
        loginCubit.passwordChanged(testPassword);
        return loginCubit;
      },
      act: (cubit) => cubit.login(),
      expect: () => [
        predicate<LoginState>((state) => state.status == LoginStatus.loading),
        predicate<LoginState>((state) => state.status == LoginStatus.failure && state.errorMessage != null && state.needsRecoverySecret == true),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'calls loginUseCase with recoveryToken when provided',
      build: () {
        when(mockLoginUseCase.execute(testEmail, testPassword, recoveryToken: testRecoveryToken)).thenAnswer((_) async => testUser);

        loginCubit.emailChanged(testEmail);
        loginCubit.passwordChanged(testPassword);
        loginCubit.setRecoveryToken(testRecoveryToken);
        return loginCubit;
      },
      act: (cubit) => cubit.login(),
      verify: (_) {
        verify(mockLoginUseCase.execute(testEmail, testPassword, recoveryToken: testRecoveryToken)).called(1);
      },
      expect: () => [
        predicate<LoginState>((state) => state.status == LoginStatus.loading),
        predicate<LoginState>((state) => state.status == LoginStatus.success && state.user == testUser),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits initial state when resetState is called',
      build: () {
        loginCubit.emailChanged(testEmail);
        loginCubit.passwordChanged(testPassword);
        loginCubit.setRecoveryToken(testRecoveryToken);
        return loginCubit;
      },
      act: (cubit) => cubit.resetState(),
      expect: () => [
        const LoginState(),
      ],
    );
  });
}
