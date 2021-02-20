import 'dart:math';

import 'package:tic_tac_no/ai/ai.dart';
import 'package:tic_tac_no/game/data/models/models.dart';

class HumanAI extends AI {
  HumanAI(Player player, Player opponent) {
    this.player = player;
    this._opponent = opponent;
  }

  Player _opponent;

  Square makeMove(Grid grid) {
    InnerGrid playableInnerGrid = this.getPlayableInnerGrid(grid);

    List<Square> playableSquares = this.getPlayableSquares(playableInnerGrid);

    Square winningSquare = this.winningSquare(
      playableInnerGrid,
      playableSquares,
      this.player,
    );
    if (winningSquare != null) {
      return winningSquare;
    }

    // check if opponent can be blocked
    Square opponentWinningSquare = this.winningSquare(
      playableInnerGrid,
      playableSquares,
      this._opponent,
    );
    if (opponentWinningSquare != null) {
      return opponentWinningSquare;
    }

    // first check if opponent can be sent to the already won inner grid
    List<Square> alreadyWonSquares = [];
    playableSquares.forEach((square) {
      if (grid.innerGrids[square.position.x][square.position.y].winner !=
          null) {
        alreadyWonSquares.add(square);
      }
    });
    if (alreadyWonSquares.length > 0) {
      final int random = Random().nextInt(alreadyWonSquares.length);
      return alreadyWonSquares[random];
    }

    // for each playable square, check if opponnent has winning
    // move in inner grid with this position
    // then definitely not move there
    List<Square> opponentNotWinningSquares = [];
    playableSquares.forEach((square) {
      final InnerGrid opponentPlayableInnerGrid =
          grid.innerGrids[square.position.x][square.position.y];
      final List<Square> opponentPlayableSquares =
          this.getPlayableSquares(opponentPlayableInnerGrid);
      final Square opponentWinningSquare = this.winningSquare(
          opponentPlayableInnerGrid, opponentPlayableSquares, this._opponent);
      if (opponentWinningSquare == null) {
        opponentNotWinningSquares.add(square);
      }
    });

    // else, if there is no option
    // certainly, avoid picking "sidings"
    List<Square> nonSidingSquares = [];
    playableSquares.forEach((square) {
      if (square.position != Position(0, 1) &&
          square.position != Position(1, 0) &&
          square.position != Position(1, 2) &&
          square.position != Position(2, 1)) {
        nonSidingSquares.add(square);
      }
    });

    // if there is a square in both of these lists, take it
    // if not, prefer opponentNotWinningMoves
    List<Square> bestMoveSquares = [];
    for (int i = 0; i < opponentNotWinningSquares.length; i++) {
      for (int j = 0; j < nonSidingSquares.length; j++) {
        if (opponentNotWinningSquares[i].position ==
            nonSidingSquares[j].position) {
          bestMoveSquares.add(opponentNotWinningSquares[i]);
        }
      }
    }

    if (bestMoveSquares.length > 0) {
      final int random = Random().nextInt(bestMoveSquares.length);
      return bestMoveSquares[random];
    }

    if (opponentNotWinningSquares.length > 0) {
      final int random = Random().nextInt(opponentNotWinningSquares.length);
      return opponentNotWinningSquares[random];
    }

    final int random = Random().nextInt(playableSquares.length);
    return playableSquares[random];
  }
}
