// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

// import 'package:tic_tac_no/translations/locale_keys.g.dart';

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

      // TODO: find out how to use localization texts in Flutter driver tests
      // await driver.waitFor(find.text(LocaleKeys.menu_change_language.tr()));

      await driver.tap(languageListTileHr);
      await driver.waitForAbsent(languageListView);

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
