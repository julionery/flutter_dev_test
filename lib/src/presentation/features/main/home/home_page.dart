import 'package:flutter/material.dart';
import 'package:flutter_dev_test/generated/l10n.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(S.current.home.toLowerCase()),
    );
  }
}
