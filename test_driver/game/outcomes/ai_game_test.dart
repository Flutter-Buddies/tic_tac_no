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
      final playerMoves = <SquarePos>[];

      OUTER: while (true) {
        await driver.clearTimeline();

        // TODO: Improve this: add already done moves by player and AI to a set so we dont wastefully iterate through them again
        for (var rowG = 0; rowG < 3; rowG++) {
          for (var columnG = 0; columnG < 3; columnG++) {
            final randomRowMove = List.generate(3, (i) => i)..shuffle();
            for (var rowSqIt = 0; rowSqIt < 3; rowSqIt++) {
              final rowSq = randomRowMove[rowSqIt];
              final randomColMove = List.generate(3, (i) => i)..shuffle();
              for (var columnSqIt = 0; columnSqIt < 3; columnSqIt++) {
                final columnSq = randomColMove[columnSqIt];
                final playerTap = SquarePos(rowG, columnG, rowSq, columnSq);

                bool gameFinished = false;
                await driver
                    .tap(
                      getGameSquareFinder(playerTap),
                      timeout: Duration(milliseconds: 5000),
                    )
                    .onError((_, __) => gameFinished = true);
                if (gameFinished) break OUTER;

                await driver
                    .waitFor(gameThinkingLabel)
                    .timeout(const Duration(milliseconds: 20))
                    .then(
                  (_) async {
                    playerMoves.add(playerTap);
                    await driver.waitForAbsent(gameThinkingLabel).timeout(
                          Duration(milliseconds: aiThinkingTime),
                          onTimeout: () {},
                        );
                  },
                  onError: (_) {},
                );
              }
            }
          }
        }
      }
      await driver.tap(gameQuitToMenuText);
      print(playerMoves.toString());

      await wait_2s();
    }, timeout: const Timeout(Duration(minutes: 10)));
  });
}
