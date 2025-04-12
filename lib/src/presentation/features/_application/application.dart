import 'package:flutter/material.dart';
import 'package:flutter_dev_test/generated/l10n.dart';
import 'package:flutter_dev_test/src/presentation/features/home/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: S.of(context).appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
