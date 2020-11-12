import 'dart:math';

import 'package:tic_tac_no/ai/ai.dart';
import 'package:tic_tac_no/game/data/models/models.dart';

class WinnerAI extends AI {
  WinnerAI(Player player) {
    this.player = player;
  }

  Square makeMove(Grid grid) {
    InnerGrid playableInnerGrid = this.getPlayableInnerGrid(grid);

    List<Square> playableSquares = this.getPlayableSquares(playableInnerGrid);

    Square winningSquare = this.winningSquare(
      playableInnerGrid,
      playableSquares,
      this.player,
    );
    if (winningSquare == null) {
      final int random = Random().nextInt(playableSquares.length);
      return playableSquares[random];
    }

    return winningSquare;
  }
}
