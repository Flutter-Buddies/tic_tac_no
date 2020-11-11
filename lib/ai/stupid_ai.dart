import 'dart:math';

import 'package:tic_tac_no/ai/ai.dart';
import 'package:tic_tac_no/game/data/models/models.dart';

class StupidAI extends AI {
  StupidAI(Player player) {
    this.player = player;
  }

  Square makeMove(Grid grid) {
    InnerGrid playableInnerGrid = this.getPlayableInnerGrid(grid);

    List<Square> playableSquares = this.getPlayableSquares(playableInnerGrid);

    ///    xxx         x__          x__
    ///    ___    OR   x__    OR    _x_
    ///    ___         x__          __x
    if (_findByPosition(playableSquares, Position(0, 0)) != null) {
      if (playableInnerGrid.squares[0][0].player == null &&
          playableInnerGrid.squares[0][1].player?.color == this.player.color &&
          playableInnerGrid.squares[0][2].player?.color == this.player.color) {
        return playableInnerGrid.squares[0][0];
      }
      if (playableInnerGrid.squares[0][0].player == null &&
          playableInnerGrid.squares[1][0].player?.color == this.player.color &&
          playableInnerGrid.squares[2][0].player?.color == this.player.color) {
        return playableInnerGrid.squares[0][0];
      }
      if (playableInnerGrid.squares[0][0].player == null &&
          playableInnerGrid.squares[1][1].player?.color == this.player.color &&
          playableInnerGrid.squares[2][2].player?.color == this.player.color) {
        return playableInnerGrid.squares[0][0];
      }
    }

    ///    xxx         _x_
    ///    ___    OR   _x_
    ///    ___         _x_
    if (_findByPosition(playableSquares, Position(0, 1)) != null) {
      if (playableInnerGrid.squares[0][1].player == null &&
          playableInnerGrid.squares[0][0].player?.color == this.player.color &&
          playableInnerGrid.squares[0][2].player?.color == this.player.color) {
        return playableInnerGrid.squares[0][1];
      }
      if (playableInnerGrid.squares[0][1].player == null &&
          playableInnerGrid.squares[1][1].player?.color == this.player.color &&
          playableInnerGrid.squares[2][1].player?.color == this.player.color) {
        return playableInnerGrid.squares[0][1];
      }
    }

    ///    xxx         __x          __x
    ///    ___    OR   __x    OR    _x_
    ///    ___         __x          x__
    if (_findByPosition(playableSquares, Position(0, 2)) != null) {
      if (playableInnerGrid.squares[0][2].player == null &&
          playableInnerGrid.squares[0][1].player?.color == this.player.color &&
          playableInnerGrid.squares[0][0].player?.color == this.player.color) {
        return playableInnerGrid.squares[0][2];
      }
      if (playableInnerGrid.squares[0][2].player == null &&
          playableInnerGrid.squares[1][0].player?.color == this.player.color &&
          playableInnerGrid.squares[2][0].player?.color == this.player.color) {
        return playableInnerGrid.squares[0][2];
      }
      if (playableInnerGrid.squares[0][2].player == null &&
          playableInnerGrid.squares[1][1].player?.color == this.player.color &&
          playableInnerGrid.squares[2][2].player?.color == this.player.color) {
        return playableInnerGrid.squares[0][2];
      }
    }

    ///    ___         x__
    ///    xxx    OR   x__
    ///    ___         x__
    if (_findByPosition(playableSquares, Position(1, 0)) != null) {
      if (playableInnerGrid.squares[1][0].player == null &&
          playableInnerGrid.squares[1][1].player?.color == this.player.color &&
          playableInnerGrid.squares[1][2].player?.color == this.player.color) {
        return playableInnerGrid.squares[1][0];
      }
      if (playableInnerGrid.squares[1][0].player == null &&
          playableInnerGrid.squares[0][0].player?.color == this.player.color &&
          playableInnerGrid.squares[2][0].player?.color == this.player.color) {
        return playableInnerGrid.squares[1][0];
      }
    }

    ///    ___         _x_          __x          x__
    ///    xxx    OR   _x_    OR    _x_    OR    _x_
    ///    ___         _x_          x__          __x
    if (_findByPosition(playableSquares, Position(1, 1)) != null) {
      if (playableInnerGrid.squares[1][1].player == null &&
          playableInnerGrid.squares[1][0].player?.color == this.player.color &&
          playableInnerGrid.squares[1][2].player?.color == this.player.color) {
        return playableInnerGrid.squares[1][1];
      }
      if (playableInnerGrid.squares[1][1].player == null &&
          playableInnerGrid.squares[0][1].player?.color == this.player.color &&
          playableInnerGrid.squares[2][1].player?.color == this.player.color) {
        return playableInnerGrid.squares[1][1];
      }
      if (playableInnerGrid.squares[1][1].player == null &&
          playableInnerGrid.squares[0][2].player?.color == this.player.color &&
          playableInnerGrid.squares[2][0].player?.color == this.player.color) {
        return playableInnerGrid.squares[1][1];
      }
      if (playableInnerGrid.squares[1][1].player == null &&
          playableInnerGrid.squares[0][0].player?.color == this.player.color &&
          playableInnerGrid.squares[2][2].player?.color == this.player.color) {
        return playableInnerGrid.squares[1][1];
      }
    }

    ///    ___         __x
    ///    xxx    OR   __x
    ///    ___         __x
    if (_findByPosition(playableSquares, Position(1, 2)) != null) {
      if (playableInnerGrid.squares[1][2].player == null &&
          playableInnerGrid.squares[1][0].player?.color == this.player.color &&
          playableInnerGrid.squares[1][1].player?.color == this.player.color) {
        return playableInnerGrid.squares[1][2];
      }
      if (playableInnerGrid.squares[1][2].player == null &&
          playableInnerGrid.squares[0][2].player?.color == this.player.color &&
          playableInnerGrid.squares[2][2].player?.color == this.player.color) {
        return playableInnerGrid.squares[1][2];
      }
    }

    ///    ___         x__          __x
    ///    ___    OR   x__    OR    _x_
    ///    xxx         x__          x__
    if (_findByPosition(playableSquares, Position(2, 0)) != null) {
      if (playableInnerGrid.squares[2][0].player == null &&
          playableInnerGrid.squares[2][1].player?.color == this.player.color &&
          playableInnerGrid.squares[2][2].player?.color == this.player.color) {
        return playableInnerGrid.squares[2][0];
      }
      if (playableInnerGrid.squares[2][0].player == null &&
          playableInnerGrid.squares[1][0].player?.color == this.player.color &&
          playableInnerGrid.squares[0][0].player?.color == this.player.color) {
        return playableInnerGrid.squares[2][0];
      }
      if (playableInnerGrid.squares[2][0].player == null &&
          playableInnerGrid.squares[1][1].player?.color == this.player.color &&
          playableInnerGrid.squares[0][2].player?.color == this.player.color) {
        return playableInnerGrid.squares[2][0];
      }
    }

    ///    ___         _x_
    ///    ___    OR   _x_
    ///    xxx         _x_
    if (_findByPosition(playableSquares, Position(2, 1)) != null) {
      if (playableInnerGrid.squares[2][1].player == null &&
          playableInnerGrid.squares[2][0].player?.color == this.player.color &&
          playableInnerGrid.squares[2][2].player?.color == this.player.color) {
        return playableInnerGrid.squares[2][1];
      }
      if (playableInnerGrid.squares[2][1].player == null &&
          playableInnerGrid.squares[1][1].player?.color == this.player.color &&
          playableInnerGrid.squares[0][1].player?.color == this.player.color) {
        return playableInnerGrid.squares[2][1];
      }
    }

    ///    ___         __x          x__
    ///    ___    OR   __x    OR    _x_
    ///    xxx         __x          __x
    if (_findByPosition(playableSquares, Position(2, 2)) != null) {
      if (playableInnerGrid.squares[2][2].player == null &&
          playableInnerGrid.squares[2][0].player?.color == this.player.color &&
          playableInnerGrid.squares[2][1].player?.color == this.player.color) {
        return playableInnerGrid.squares[2][2];
      }
      if (playableInnerGrid.squares[2][2].player == null &&
          playableInnerGrid.squares[1][2].player?.color == this.player.color &&
          playableInnerGrid.squares[0][2].player?.color == this.player.color) {
        return playableInnerGrid.squares[2][2];
      }
      if (playableInnerGrid.squares[2][2].player == null &&
          playableInnerGrid.squares[1][1].player?.color == this.player.color &&
          playableInnerGrid.squares[0][0].player?.color == this.player.color) {
        return playableInnerGrid.squares[2][2];
      }
    }

    final int random = Random().nextInt(playableSquares.length);
    return playableSquares[random];
  }

  Square _findByPosition(List<Square> squares, Position position) {
    for (int i = 0; i < squares.length; i++) {
      if (squares[i].position.x == position.x &&
          squares[i].position.y == position.y) {
        return squares[i];
      }
    }
    return null;
  }
}
