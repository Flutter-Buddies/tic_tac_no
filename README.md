# Tic-Tac-No

![test](https://github.com/Flutter-Buddies/tic_tac_no/workflows/test/badge.svg)
![build](https://github.com/Flutter-Buddies/tic_tac_no/workflows/build/badge.svg)

Complex variants of tic-tac-toe game.

## Give it a try?

For now we have the game on the Google Play Store and working on having it published to the Apple App Store

<a href='https://play.google.com/store/apps/details?id=com.flutterbuddies.tic_tac_no&pcampaignid=pcampaignidMKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1'><img alt='Get it on Google Play' src='https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png' width="250px" /></a>

## Contributing

Please read the [contribution guidelines](CONTRIBUTING.md).

<p align="center">
<img src="https://raw.githubusercontent.com/Flutter-Buddies/tic_tac_no/master/doc/assets/1.png" alt="gitflow" width="420" style="margin-right:16px;margin-bottom:16px"> 
</p>

## Adding Support for a New Language

To add a language follow the following steps:

- Fork this repository
- Create a branch from `master` with name `add_{YOUR_LANGUAGE_NAME}_language`, so for example `add_arabic_language`
- Create a new JSON file in `assets/translations` folder with the name of the language code only, no country specificatiom. So like `ar.json` for Arabic.
- Fill the file with all missing values by opening the translations folder in `i18n Manager` app, [download here](https://github.com/gilmarsquinelato/i18n-manager/releases/tag/3.0.3) for your OS. This app will make your life so musch easier 😉


After filling the newly created file:
- Add a new entry in the `Info.plist` of iOS located at `ios/Runner/Info.plist` under the array of `CFBundleLocalizations`, append it to the end with the language code.
Example of this:

Before:
```xml
<key>CFBundleLocalizations</key>
<array>
	<string>en</string>
	<string>ar</string>
</array>
```
After:
```xml
<key>CFBundleLocalizations</key>
<array>
	<string>en</string>
	<string>ar</string>
    <string>{YOUR_LANGUAGE_CODE}</string>
</array>
```

- Append your locale to the `supportedLocales` in the `main.dart` file like so:

Before:
```dart
supportedLocales: [
    Locale('en'),
    Locale('ar'),
],
```
After:
```dart
supportedLocales: [
    Locale('en'),
    Locale('ar'),
    Locale('{YOUR_LANGUAGE_CODE}'),
],
```

- Run the generator by running the following commands in a terminal in the app root directory:
```bash
$ flutter pub run easy_localization:generate -S "assets/translations" -O "lib/translations"

$ flutter pub run easy_localization:generate -S "assets/translations" -O "lib/translations" -o "locale_keys.g.dart" -f keys
```

- Create a Pull Request 🚀