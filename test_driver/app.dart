import 'package:flutter_driver/driver_extension.dart';
import 'package:tic_tac_no/main.dart' as app;

/// Running on:
/// - an emulator with:
///   flutter drive --target=test_driver/app.dart
/// - or on a physical device with:
///   flutter drive --profile --target=test_driver/app.dart
void main() {
  enableFlutterDriverExtension();
  app.main();
}
