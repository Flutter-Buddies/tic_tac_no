import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../../test_finders.dart';
import '../../test_helpers.dart';

void main() {
  // TODO:
  group('Game screen - Random outcome: Player vs AI (Hard) random game', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('set up game settings', () async {
      //
    });

    test('play game', () {
      //
    });
  });
}
