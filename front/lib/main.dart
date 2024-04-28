import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xakaton/features/app/app.dart';

void main() {
  runApplication();
}

/// Run proccess of app. (init, run)
Future<void> runApplication() async {
  await _initialization();

  runApp(const App());
}

Future<void> _initialization() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
  );
}
