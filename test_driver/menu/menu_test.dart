import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../test_finders.dart';
import '../test_helpers.dart';

void main() {
  group('Menu screen', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('mute/unmute', () async {
      await wait_1s();
      await driver.tap(menuSoundBtn);

      await wait_1s();
      await driver.tap(menuSoundBtn);
    });

    test('show language settings', () async {
      await driver.tap(menuLangBtn);
      await wait_1s();

      await driver.tap(languageListTileEn);
      await driver.waitForAbsent(languageListView);
      final unchangedText = await driver.getText(menuHowToPlayText);

      await driver.tap(menuLangBtn);
      await wait_1s();

      await driver.tap(languageListTileHr);
      await driver.waitForAbsent(languageListView);
      final changedText = await driver.getText(menuHowToPlayText);

      print('$unchangedText\n$changedText');
      expect(unchangedText, isNot(equals(changedText)));

      await driver.tap(menuLangBtn);
      await wait_custom(milliseconds: 1500);

      await driver.scroll(
          languageListView, 0, -500, const Duration(milliseconds: 500));

      await driver.tap(languageListTileCs);
      await driver.waitForAbsent(languageListView);

      await driver.tap(menuLangBtn);
      await wait_custom(milliseconds: 1500);

      await driver.tap(languageListTileEn);
      await wait_custom(milliseconds: 2000);
    });
  });
}
