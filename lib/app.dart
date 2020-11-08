import 'package:flutter/material.dart';

import 'package:tic_tac_no/game/ui/game_screen.dart';
import 'package:tic_tac_no/menu/menu_screen.dart';
import 'package:tic_tac_no/settings/settings_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic-Tac-No',
      routes: {
        '/': (context) => MenuScreen(),
        '/settings': (context) => SettingsScreen(),
        '/game': (context) => GameScreen()
      },
    );
  }
}
