import 'package:flutter/material.dart';
import 'package:flutter_dev_test/src/data/data.dart';
import 'package:flutter_dev_test/src/domain/domain.dart';
import 'package:flutter_dev_test/src/presentation/features/_application/application.dart';
import 'package:flutter_dev_test/src/presentation/presentation.dart';

void main() async {
  await Data.init();
  await Domain.init();
  await Presentation.init();

  runApp(const MyApp());
}
