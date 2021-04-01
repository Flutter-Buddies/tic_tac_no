import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tic_tac_no/contributers/ui/contributers_screen.dart';

import 'package:tic_tac_no/game/ui/game_screen.dart';
import 'package:tic_tac_no/menu/menu_screen.dart';
import 'package:tic_tac_no/rules/rules_screen.dart';

import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:tic_tac_no/translations/locale_keys.g.dart';
import 'package:tic_tac_no/utils/utils.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// restrict app to only portrait mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
    );
    // Sets the app to full screen
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: LocaleKeys.global_app_name.tr(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routes: {
        '/': (context) => MenuScreen(),
        '/rules': (context) => RulesScreen(),
        '/game': (context) => GameScreen(),
        '/contributors': (context) => ContributersScreen(),
      },
      builder: (BuildContext context, Widget child) {
        return Directionality(
          textDirection: Utils.isCurrentLocaleRTL(context)
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: child,
        );
      },
    );
  }
}
