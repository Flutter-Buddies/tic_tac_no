@Timeout(Duration(minutes: 2))
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../../test_finders.dart';
import '../../test_helpers.dart';
import '../square_pos.dart';

void main() {
  group('Game screen - Players vs Player', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('outcome 1): player O wins', () async {
      await driver.tap(gameSetupStartBtn);

      for (var i = 0; i < outcome1.length; i++) {
        await driver.tap(getGameSquareFinder(outcome1[i]));
        await wait_custom(milliseconds: 150);
      }

      await wait_650ms();
      await driver.waitFor(gameQuitToMenuText);
      await driver.tap(gameQuitToMenuText);
    }, timeout: const Timeout(Duration(minutes: 15)));
  });
}

// O
// X O
//     O
const outcome1 = <SquarePos>[
  SquarePos(1, 0, 1, 1),
  SquarePos(1, 1, 0, 0, playerId: 2),
  SquarePos(0, 0, 0, 0),
  SquarePos(0, 0, 1, 2, playerId: 2),
  SquarePos(1, 2, 1, 1),
  SquarePos(1, 1, 1, 1, playerId: 2),
  SquarePos(1, 1, 2, 0),
  SquarePos(2, 0, 0, 0, playerId: 2),
  SquarePos(0, 0, 1, 1),
  SquarePos(1, 1, 2, 2, playerId: 2),
  SquarePos(2, 2, 0, 0),
  SquarePos(0, 0, 0, 2, playerId: 2),
  SquarePos(0, 2, 0, 0),
  SquarePos(0, 0, 1, 0, playerId: 2),
  SquarePos(1, 0, 0, 0),
  SquarePos(0, 0, 2, 2, playerId: 2),
  SquarePos(2, 2, 0, 1),
  SquarePos(0, 1, 1, 0, playerId: 2),
  SquarePos(1, 0, 2, 2), // PLAYER 1 WINS [1][0] GRID
  SquarePos(2, 2, 0, 2, playerId: 2),
  SquarePos(0, 2, 2, 2),
  SquarePos(2, 2, 1, 2, playerId: 2),
  SquarePos(1, 2, 2, 2),
  SquarePos(2, 2, 2, 2, playerId: 2), // PLAYER 2 WINS [2][2] GRID
];
