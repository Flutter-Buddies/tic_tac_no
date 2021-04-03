import 'dart:math';

import 'package:tic_tac_no/ai/ai.dart';
import 'package:tic_tac_no/game/data/models/models.dart';

class WinnerAI extends AI {
  WinnerAI(Player player) {
    this.player = player;
  }

  @override
  Square makeMove(Grid grid) {
    final playableInnerGrid = this.getPlayableInnerGrid(grid);

    final playableSquares = this.getPlayableSquares(playableInnerGrid);

    final winningSquare = this.winningSquare(
      playableInnerGrid,
      playableSquares,
      this.player,
    );
    if (winningSquare == null) {
      final random = Random().nextInt(playableSquares.length);
      return playableSquares[random];
    }

    return winningSquare;
  }
}
