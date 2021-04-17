# Tic-Tac-No

![build](https://github.com/Flutter-Buddies/tic_tac_no/workflows/build/badge.svg)
![tests](https://github.com/Flutter-Buddies/tic_tac_no/workflows/tests/badge.svg)

Complex variants of tic-tac-toe game.

## Live Coding

You can join us on [Discord](https://discord.gg/HBePsn7244) every Saturday at 17:30 UTC to watch the live coding of this app, give your feedback and make suggestions.

## Give it a try?

For now we have the game on the Google Play Store and working on having it published to the Apple App Store

<a href='https://play.google.com/store/apps/details?id=com.flutterbuddies.tic_tac_no&pcampaignid=pcampaignidMKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1'><img alt='Get it on Google Play' src='https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png' width="250px" /></a>

<p align="center">
<img src="https://raw.githubusercontent.com/Flutter-Buddies/tic_tac_no/master/doc/assets/1.png" alt="gitflow" width="420" style="margin-right:16px;margin-bottom:16px"> 
</p>

## Contributing

Please read the [contribution guidelines](CONTRIBUTING.md).

## Testing

### Unit

TBA

### Integration

#### Running the tests

- on emulator with:
 `flutter drive --target=test_driver/app.dart`
 - or on a physical device with:
 ` flutter drive --profile --target=test_driver/app.dart`

Current flow:
1. Menu segment: Mute/unmute, Change language 3 times
2. Rules segment: Iterate through all rules
3. Game segments - Setup game mode & play:
   -  random game vs AI (hard difficulty)
   -  predefined sequence - local game (player vs player) - expected outcome:
```
O 
X O 
    O
```

Segments can be commented out in `test_driver/app_test.dart`
