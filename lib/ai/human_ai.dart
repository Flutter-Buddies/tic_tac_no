import 'dart:math';

import 'package:tic_tac_no/ai/ai.dart';
import 'package:tic_tac_no/game/data/models/models.dart';

class HumanAI extends AI {
  HumanAI(Player player, Player opponent) {
    this.player = player;
    this._opponent = opponent;
  }

  Player _opponent;

  @override
  Square makeMove(Grid grid) {
    final playableInnerGrid = this.getPlayableInnerGrid(grid);

    final playableSquares = this.getPlayableSquares(playableInnerGrid);

    final winningSquare = this.winningSquare(
      playableInnerGrid,
      playableSquares,
      this.player,
    );
    if (winningSquare != null) {
      return winningSquare;
    }

    // check if opponent can be blocked
    final opponentWinningSquare = this.winningSquare(
      playableInnerGrid,
      playableSquares,
      this._opponent,
    );
    if (opponentWinningSquare != null) {
      return opponentWinningSquare;
    }

    // first check if opponent can be sent to the already won inner grid
    final alreadyWonSquares = <Square>[];
    playableSquares.forEach((square) {
      if (grid.innerGrids[square.position.x][square.position.y].winner !=
          null) {
        alreadyWonSquares.add(square);
      }
    });
    if (alreadyWonSquares.isNotEmpty) {
      final random = Random().nextInt(alreadyWonSquares.length);
      return alreadyWonSquares[random];
    }

    // for each playable square, check if opponnent has winning
    // move in inner grid with this position
    // then definitely not move there
    final opponentNotWinningSquares = <Square>[];
    playableSquares.forEach((square) {
      final opponentPlayableInnerGrid =
          grid.innerGrids[square.position.x][square.position.y];
      final opponentPlayableSquares =
          this.getPlayableSquares(opponentPlayableInnerGrid);
      final opponentWinningSquare = this.winningSquare(
          opponentPlayableInnerGrid, opponentPlayableSquares, this._opponent);
      if (opponentWinningSquare == null) {
        opponentNotWinningSquares.add(square);
      }
    });

    // else, if there is no option
    // certainly, avoid picking "sidings"
    final nonSidingSquares = <Square>[];
    playableSquares.forEach((square) {
      if (square.position != const Position(0, 1) &&
          square.position != const Position(1, 0) &&
          square.position != const Position(1, 2) &&
          square.position != const Position(2, 1)) {
        nonSidingSquares.add(square);
      }
    });

    // if there is a square in both of these lists, take it
    // if not, prefer opponentNotWinningMoves
    final bestMoveSquares = <Square>[];
    for (var i = 0; i < opponentNotWinningSquares.length; i++) {
      for (var j = 0; j < nonSidingSquares.length; j++) {
        if (opponentNotWinningSquares[i].position ==
            nonSidingSquares[j].position) {
          bestMoveSquares.add(opponentNotWinningSquares[i]);
        }
      }
    }

    if (bestMoveSquares.isNotEmpty) {
      final random = Random().nextInt(bestMoveSquares.length);
      return bestMoveSquares[random];
    }

    if (opponentNotWinningSquares.isNotEmpty) {
      final random = Random().nextInt(opponentNotWinningSquares.length);
      return opponentNotWinningSquares[random];
    }

    final random = Random().nextInt(playableSquares.length);
    return playableSquares[random];
  }
}
