# Contribution Guidelines

This document will briefly describe basic guidelines for contributors. All project communication shall be done at [issues](https://github.com/Flutter-Buddies/tic_tac_no/issues) or FlutterBuddies Discord  [server](https://discord.gg/X3pfRES6). Everything in this text that you find confusing or have any objections, can and should be discussed at issues or Discord.

The upcoming titles sort of describe the order of things you want to explore before contributing.

## Discord

If you'd like to talk about the project in general, please do at project's Discord [channel](https://discord.com/channels/768528774991446088/774393854317035580). We can go on from there.

## Issues

Issues at this repository are a main place to look at when planning to contribute. Two situations can occur:

**Your idea is already present in an issue**

In this case, after reading all the comments at this issue to assess the situation and how it aligns with your ideas, you can

- add your comment with some further insight or a question
- contact issue's assignee (either by leaving a comment with assignee tagged or contacting assignee directly) for details on how can you contribute code

**You have an idea not present in issues**

In this case, you can create a new issue with detailed explanation of your idea, question or bug report with minimal code example if applicable. Then the other contributors will comment further at your issue and you can plan how this will be developed. By default, you can then become the assignee at this issue, the one who will be responsible for it's development. Of course, this is not forced upon anyone so you can let us know in the comments that you prefer not to be the assignee. Then others can apply to be the assignee.

If an issue doesn't have an assignee, the position is open for anyone who wants it. In this assigneeless situation, the "acting assignee" is the project creator (slovnicki / sly).

## Branches

We will try to work by the [GitFlow](https://nvie.com/posts/a-successful-git-branching-model/) branching model to keep ourselfs organized and with as little conflicts as possible. If you want to know more about this, read the link, but it is not necessary. Everything will be explained well enough here.

<p align="center">
<img src="https://raw.githubusercontent.com/Flutter-Buddies/tic_tac_no/master/doc/assets/gitflow.png" alt="gitflow" width="420" style="margin-right:16px;margin-bottom:16px"> 
</p>

We have 3 main branches and these are rarely of concern for most of contributors. We will not use `release` branch for now, but handle this in `master`.

- `master` branch is the one no one should worry about for some time. This is the branch that holds the latest stable version of our project.

- `hotfix` branch is closely related to `master` and is used to fix bugs that simply cannot wait.

- `develop` branch was created from `master` and will be sometime in the future merged into it again. All other branches (except `hotfix` branch) are branched from `develop` and will be merged into `develop`.

Many feature branches

- `settings` branch was created from `develop` to specifically work on `settings/` part of the app

- `ai/*` branches were created from `develop` to specifically work on AI part of the app

- `game` branch was created from `develop` to specifically work on `game/` part of the app

- ...

After there are some useful changes done at some feature branch, Pull Request shall be created to merge it into `develop`. Then we will review changes, maybe have a discussion at pull request's comments section and finally merge it. Of course, in practice there will be little discussion to be made if everything works as expected.

Then, other feature branches can (but don't have to) pull these changes from `develop` to have the latest development state.

## Pull Requests

To contribute, you will eventually be doing a Pull Request for your fork. First, you need to fork the repository and set the upstream via `git remote add upstream https://github.com/Flutter-Buddies/tic_tac_no.git`.

When you fork the project, you will be at `master` branch by default. To switch branches, use `git checkout <branch-name>`. It will be clearly discussed on which branch should each issue be worked on.

If you are contributing at some branch for a while, to have the latest changes if something has been pushed in the meantime, do `git fetch upstream`. This will create branches `upstream/<branch-name>` that you then need to merge into your branch you're working on. To do that, `git checkout <branch-name>` (if you're not already on it) and `git merge upstream/<branch-name>`.

### Useful links

- [Git Handbook](https://guides.github.com/introduction/git-handbook)
- [GitHub Hello World](https://guides.github.com/activities/hello-world/)
- [git branches - official GitHub docs](https://docs.github.com/en/free-pro-team@latest/github/collaborating-with-issues-and-pull-requests/about-branches)
- [Fork - official GitHub docs](https://docs.github.com/en/free-pro-team@latest/github/getting-started-with-github/fork-a-repo)
- [Syncing a fork - official GitHub docs](https://docs.github.com/en/free-pro-team@latest/github/collaborating-with-issues-and-pull-requests/syncing-a-fork)
- [Syncing a fork - StackOverflow](https://stackoverflow.com/questions/7244321/how-do-i-update-a-github-forked-repository)
- [Creating a pull request from a fork - official GitHub docs](https://docs.github.com/en/free-pro-team@latest/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request-from-a-fork)


## Code Style

It is sufficient that you format your code. See [here](https://flutter.dev/docs/development/tools/formatting) how this can be accomplished and automated.

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

- If the new language is a `RTL` language add it to the switch statement as a case returning true like this:

Before:
```dart
bool isCurrentLocaleRTL(BuildContext context) {
    switch (context.locale.languageCode) {
      case 'ar':
        return true;
        break;
      default:
        return false;
    }
}
```
After:
```dart
bool isCurrentLocaleRTL(BuildContext context) {
    switch (context.locale.languageCode) {
      case 'ar':
      case '{YOUR_LANGUAGE_CODE}': // only if rtl, else it will be false
        return true;
        break;
      default:
        return false;
    }
}
```

- Add a new value to the `SupportedLocale` enum located at `lib/utils/utils.dart` with the language code you are adding like this:

Before:
```dart
enum SupportedLocale {
  en,
  ar,
}
```
After:
```dart
enum SupportedLocale {
  en,
  ar,
  {YOUR_LANGUAGE_CODE}, // here
}
```

- Add a new case to the switch statement located at `lib/utils/utils.dart`:

Before:
```dart
static void changeLocale(
    BuildContext context,
    SupportedLocale supportedLocale,
) {
    Locale locale;

    switch (supportedLocale) {
      case SupportedLocale.en:
        locale = Locale('en');
        break;
      case SupportedLocale.ar:
        locale = Locale('ar');
        break;
      default:
        locale = Locale('en');
        break;
    }

    EasyLocalization.of(context).locale = locale;
}
```
After:
```dart
static void changeLocale(
    BuildContext context,
    SupportedLocale supportedLocale,
) {
    Locale locale;

    switch (supportedLocale) {
      case SupportedLocale.en:
        locale = Locale('en');
        break;
      case SupportedLocale.ar:
        locale = Locale('ar');
        break;
      case SupportedLocale.YOUR_LANGUAGE_CODE: // here
        locale = Locale('{YOUR_LANGUAGE_CODE}'); // here
        break; // here
      default:
        locale = Locale('en');
        break;
    }

    EasyLocalization.of(context).locale = locale;
}
```

- Add a new `LanguageListTile` at `lib/menu/ui/language_bottom_sheet.dart`

Before:
```dart
Expanded(
  child: ListView(
    children: [
      /// emojis from: https://emojipedia.org/flags/
      LanguageListTile(
        languageEmoji: '🇬🇧',
        languageName: 'English',
        showCheck: Utils.currentLocale(context) == Locale('en'),
        locale: SupportedLocale.en,
      ),
      LanguageListTile(
        languageEmoji: '🇸🇦',
        languageName: 'العربية',
        showCheck: Utils.currentLocale(context) == Locale('ar'),
        locale: SupportedLocale.ar,
      ),
    ],
  ),
),
```
After:
```dart
Expanded(
  child: ListView(
    children: [
      /// emojis from: https://emojipedia.org/flags/
      LanguageListTile(
        languageEmoji: '🇬🇧',
        languageName: 'English',
        showCheck: Utils.currentLocale(context) == Locale('en'),
        locale: SupportedLocale.en,
      ),
      LanguageListTile(
        languageEmoji: '🇸🇦',
        languageName: 'العربية',
        showCheck: Utils.currentLocale(context) == Locale('ar'),
        locale: SupportedLocale.ar,
      ),
      LanguageListTile(
        languageEmoji: '{EMOJI_FOR_LANGUAGE}', //get emoji from https://emojipedia.org/flags/
        languageName: '{YOUR_LANGUAGE_NAME_IN_NATIVE_WAY_NOT_IN_ENGLISH}', // change this
        showCheck: Utils.currentLocale(context) == Locale('{YOUR_LANGUAGE_CODE}'), // change this
        locale: SupportedLocale.YOUR_LANGUAGE_CODE, // change this
      ),
    ],
  ),
),
```

- Create a Pull Request 🚀