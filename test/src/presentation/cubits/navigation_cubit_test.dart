import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_dev_test/src/presentation/cubits/navigation_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NavigationCubit', () {
    late NavigationCubit navigationCubit;

    setUp(() {
      navigationCubit = NavigationCubit();
    });

    tearDown(() {
      navigationCubit.close();
    });

    test('starts with state 0', () {
      expect(navigationCubit.state, 0);
    });

    blocTest<NavigationCubit, int>(
      'outputs 1 when navigateTo(1) is called',
      build: () => NavigationCubit(),
      act: (cubit) => cubit.navigateTo(1),
      expect: () => [1],
    );

    blocTest<NavigationCubit, int>(
      'emits 1 and then 2 when navigateTo(1) and navigateTo(2) are called',
      build: () => NavigationCubit(),
      act: (cubit) {
        cubit.navigateTo(1);
        cubit.navigateTo(2);
      },
      expect: () => [1, 2],
    );
  });
}
