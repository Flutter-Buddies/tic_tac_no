// @dart = 2.10

import 'game/outcomes/ai_game.dart' as ai_game;
import 'game/outcomes/player_game.dart' as player_game;
import 'menu/menu_test.dart' as menu_test;
import 'menu/rules_test.dart' as rules_test;

// for faster testing some segments can be commented out
void main() {
  menu_test.main();
  rules_test.main();
  player_game.main();
  ai_game.main();
}
