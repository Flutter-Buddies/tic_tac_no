@Timeout(Duration(minutes: 2))
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../test_finders.dart';
import '../test_helpers.dart';

void main() {
  group('Setup game mode', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('set up game settings', () async {
      await wait_2s();
      await driver.tap(menuGameOnlineMpBtn);
      await wait_1s();

      await driver.tap(menuGameSpBtn);
      await wait_650ms();

      await driver.scroll(
          gameSetupModalSheet, 0, 500, const Duration(milliseconds: 200));
      await wait_650ms();

      await driver.tap(menuGameLocalMpBtn);
      await wait_650ms();

      await driver.tap(getPlayerColorFinder(colorPos: 1));
      await wait_250ms();

      await driver.tap(getPlayerColorFinder(playerId: 2, colorPos: 1));
      await wait_250ms();

      await driver.tap(getPlayerColorFinder(playerId: 2, colorPos: 0));
      await wait_250ms();

      await () async {
        await driver.tap(gameSetupPlayer1Piece);
        await wait_650ms();
      }.execute3Times();
    });
  });
}
