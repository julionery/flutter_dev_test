import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Presentation {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
