import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dev_test/generated/l10n.dart';
import 'package:flutter_dev_test/src/presentation/cubits/navigation_cubit.dart';
import 'package:flutter_dev_test/src/presentation/features/main/home/home_page.dart';
import 'package:flutter_dev_test/src/presentation/features/main/profile/profile_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  static final List<Widget> _pages = [
    HomePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          body: IndexedStack(
            index: currentIndex,
            children: _pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) => context.read<NavigationCubit>().navigateTo(index),
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: S.of(context).home,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.person),
                label: S.of(context).profile,
              ),
            ],
          ),
        );
      },
    );
  }
}
