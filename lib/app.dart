import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tic_tac_no/game/ui/game_screen.dart';
import 'package:tic_tac_no/menu/menu_screen.dart';
import 'package:tic_tac_no/rules/rules_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: 'Tic-Tac-No',
      routes: {
        '/': (context) => MenuScreen(),
        '/rules': (context) => RulesScreen(),
        '/game': (context) => GameScreen()
      },
    );
  }
}
