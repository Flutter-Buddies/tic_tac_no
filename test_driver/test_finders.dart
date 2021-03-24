import 'package:flutter_driver/flutter_driver.dart';
import 'package:tic_tac_no/common/consts/keys.dart';

import 'game/square_pos.dart';

// home page menu
final menuHowToPlayText = find.byValueKey(Keys.menuHowToPlayText);
final menuLangBtn = find.byValueKey(Keys.menuLanguageBtn);
final menuSoundBtn = find.byValueKey(Keys.menuSoundBtn);
final menuRulesBtn = find.byValueKey(Keys.menuRulesBtn);

// menu language settings
final languageListView = find.byValueKey(Keys.languageListView);
final languageListTileEn = find.byValueKey(Keys.languageListTile + 'en');
final languageListTileHr = find.byValueKey(Keys.languageListTile + 'hr');
final languageListTileCs = find.byValueKey(Keys.languageListTile + 'cs');

// menu rules
final rulesAppBarBackBtn = find.byType('BackButton');
final rulesPreviousBtn = find.byValueKey(Keys.rulesPreviousBtn);
final rulesNextBtn = find.byValueKey(Keys.rulesNextBtn);
final rulesStartBtn = find.byValueKey(Keys.rulesStartBtn);

// menu primary buttons
final menuGameSpBtn = find.byValueKey(Keys.menuGameSpBtn);
final menuGameLocalMpBtn = find.byValueKey(Keys.menuGameLocalMpBtn);
final menuGameOnlineMpBtn = find.byValueKey(Keys.menuGameOnlineMpBtn);

// game mode setup
final gameSetupPlayer1Piece = find.byValueKey(Keys.gameSetupPlayer1Piece);
final gameSetupPlayer2Piece = find.byValueKey(Keys.gameSetupPlayer2Piece);
final gameSetupDifficultyR = find.byValueKey(Keys.gameSetupDifficultyR);
final gameSetupStartBtn = find.byValueKey(Keys.gameSetupStartBtn);
final gameSetupModalSheet = find.byValueKey(Keys.gameSetupModalSheet);

SerializableFinder getPlayerColorFinder({
  int playerId = 1,
  int colorPos = 0,
}) {
  if (playerId != 1) {
    return find.byValueKey(Keys.gameSetupPlayer2Colour + colorPos.toString());
  }
  return find.byValueKey(Keys.gameSetupPlayer1Colour + colorPos.toString());
}

// game
final gameThinkingLabel = find.byValueKey(Keys.gameThinkingLabel);
final gameBackBtn = find.byValueKey(Keys.gameBackBtn);
final gameQuitToMenuText = find.byValueKey(Keys.gameQuitToMenuText);

// format: gameSquare_G[row][column]_SQ[row][column]
// G ... grid, SQ ... small square
SerializableFinder getGameSquareFinder(SquarePos squarePos) {
  final gY = squarePos.gY;
  final gX = squarePos.gX;
  final sqY = squarePos.sqY;
  final sqX = squarePos.sqX;
  return find.byValueKey('${Keys.gameSquare}G[$gY][$gX]_SQ[$sqY][$sqX]');
}
