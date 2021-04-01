@Timeout(Duration(minutes: 2))
import 'dart:async';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../../test_finders.dart';
import '../../test_helpers.dart';
import '../square_pos.dart';

void main() {
  group('Game screen - Random outcome: Player vs AI (Hard) random game', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('set up hard difficulty and start', () async {
      await driver.tap(menuGameSpBtn);
      await wait_650ms();

      () async {
        await driver.tap(gameSetupDifficultyR);
      }.executeNTimes(2);
      await wait_1s();

      await driver.tap(gameSetupStartBtn);
      await wait_650ms();
    });

    test('play game', () async {
      bool gameFinished = false;
      final allPossibleMoves = _getAllPossibleMoves().toList()..shuffle();

      OUTER:
      while (true) {
        await driver.clearTimeline();

        // final allPossibleMovesCopy = List.of(allPossibleMoves);
        for (final squarePos in allPossibleMoves) {
          await driver
              .tap(
                getGameSquareFinder(squarePos),
                timeout: Duration(milliseconds: 5000),
              )
              .onError((_, __) => gameFinished = true);

          if (gameFinished) break OUTER;

          await driver
              .waitFor(gameThinkingLabel)
              .timeout(const Duration(milliseconds: 20))
              .then(
            (_) async {
              // allPossibleMoves.remove(squarePos);
              await driver.waitForAbsent(gameThinkingLabel).timeout(
                    Duration(milliseconds: aiThinkingTime),
                    onTimeout: () {},
                  );
            },
            onError: (_) {},
          );
        }
      }

      await driver.tap(gameQuitToMenuText);
      await wait_2s();
    }, timeout: const Timeout(Duration(minutes: 20)));
  });
}

Set<SquarePos> _getAllPossibleMoves() {
  final allPossibleMoves = <SquarePos>{};
  for (var rowG = 0; rowG < 3; rowG++) {
    for (var columnG = 0; columnG < 3; columnG++) {
      for (var rowSq = 0; rowSq < 3; rowSq++) {
        for (var columnSq = 0; columnSq < 3; columnSq++) {
          final squarePos = SquarePos(rowG, columnG, rowSq, columnSq);
          allPossibleMoves.add(squarePos);
        }
      }
    }
  }
  return allPossibleMoves;
}
