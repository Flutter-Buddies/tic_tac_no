// @dart = 2.10

@Timeout(Duration(minutes: 2))
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../test_finders.dart';
import '../test_helpers.dart';

void main() {
  group('Menu - Rules screen', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('open and go back', () async {
      await driver.tap(menuRulesBtn);
      await wait_650ms();

      await driver.tap(rulesAppBarBackBtn);
      await wait_650ms();
    });

    test('navigate through all rules', () async {
      await driver.tap(menuRulesBtn);
      await wait_650ms();

      await driver.tap(rulesNextBtn);
      await wait_650ms();

      await driver.tap(rulesPreviousBtn);
      await wait_650ms();

      await () async {
        await driver.tap(rulesNextBtn);
        await wait_650ms();
      }.execute3Times();

      await driver.tap(rulesPreviousBtn);
      await wait_650ms();

      await driver.tap(rulesNextBtn);
      await wait_650ms();

      await driver.tap(rulesNextBtn);
      await wait_650ms();

      await driver.tap(rulesStartBtn);
      await wait_650ms();
    });
  });
}
