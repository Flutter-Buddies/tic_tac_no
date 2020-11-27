import 'package:tic_tac_no/game/data/models/models.dart';
import 'package:tic_tac_no/game/data/models/square.dart';

abstract class AI {
  Player player;

  Square makeMove(Grid grid);

  InnerGrid getPlayableInnerGrid(Grid grid) {
    InnerGrid playableInnerGrid;
    grid.innerGrids.forEach((innerGrids) {
      innerGrids.forEach((innerGrid) {
        if (innerGrid.isPlayable) {
          playableInnerGrid = innerGrid;
        }
      });
    });
    return playableInnerGrid;
  }

  List<Square> getPlayableSquares(InnerGrid innerGrid) {
    List<Square> playableSquares = [];
    innerGrid.squares.forEach((squares) {
      squares.forEach((square) {
        if (square.player == null) {
          playableSquares.add(square);
        }
      });
    });
    return playableSquares;
  }

  Square findSquareByPosition(List<Square> squares, Position position) {
    for (int i = 0; i < squares.length; i++) {
      if (squares[i].position.x == position.x &&
          squares[i].position.y == position.y) {
        return squares[i];
      }
    }
    return null;
  }

  Square winningSquare(
    InnerGrid playableInnerGrid,
    List<Square> playableSquares,
    Player player,
  ) {
    if (playableInnerGrid.winner != null) {
      return null;
    }

    ///    xxx         x__          x__
    ///    ___    OR   x__    OR    _x_
    ///    ___         x__          __x
    ///
    ///   _ _ _ _ _
    ///   _ _ _ _ _
    ///   _ _ _ _ _
    ///   _ _ _ _ _
    ///   _ _ _ _ _
    if (this.findSquareByPosition(playableSquares, Position(0, 0)) != null) {
      if (playableInnerGrid.squares[0][1].player == player &&
          playableInnerGrid.squares[0][2].player == player) {
        return playableInnerGrid.squares[0][0];
      }
      if (playableInnerGrid.squares[1][0].player == player &&
          playableInnerGrid.squares[2][0].player == player) {
        return playableInnerGrid.squares[0][0];
      }
      if (playableInnerGrid.squares[1][1].player == player &&
          playableInnerGrid.squares[2][2].player == player) {
        return playableInnerGrid.squares[0][0];
      }
    }

    ///    xxx         _x_
    ///    ___    OR   _x_
    ///    ___         _x_
    if (this.findSquareByPosition(playableSquares, Position(0, 1)) != null) {
      if (playableInnerGrid.squares[0][0].player == player &&
          playableInnerGrid.squares[0][2].player == player) {
        return playableInnerGrid.squares[0][1];
      }
      if (playableInnerGrid.squares[1][1].player == player &&
          playableInnerGrid.squares[2][1].player == player) {
        return playableInnerGrid.squares[0][1];
      }
    }

    ///    xxx         __x          __x
    ///    ___    OR   __x    OR    _x_
    ///    ___         __x          x__
    if (this.findSquareByPosition(playableSquares, Position(0, 2)) != null) {
      if (playableInnerGrid.squares[0][1].player == player &&
          playableInnerGrid.squares[0][0].player == player) {
        return playableInnerGrid.squares[0][2];
      }
      if (playableInnerGrid.squares[1][2].player == player &&
          playableInnerGrid.squares[2][2].player == player) {
        return playableInnerGrid.squares[0][2];
      }
      if (playableInnerGrid.squares[1][1].player == player &&
          playableInnerGrid.squares[2][0].player == player) {
        return playableInnerGrid.squares[0][2];
      }
    }

    ///    ___         x__
    ///    xxx    OR   x__
    ///    ___         x__
    if (this.findSquareByPosition(playableSquares, Position(1, 0)) != null) {
      if (playableInnerGrid.squares[1][1].player == player &&
          playableInnerGrid.squares[1][2].player == player) {
        return playableInnerGrid.squares[1][0];
      }
      if (playableInnerGrid.squares[0][0].player == player &&
          playableInnerGrid.squares[2][0].player == player) {
        return playableInnerGrid.squares[1][0];
      }
    }

    ///    ___         _x_          __x          x__
    ///    xxx    OR   _x_    OR    _x_    OR    _x_
    ///    ___         _x_          x__          __x
    if (this.findSquareByPosition(playableSquares, Position(1, 1)) != null) {
      if (playableInnerGrid.squares[1][0].player == player &&
          playableInnerGrid.squares[1][2].player == player) {
        return playableInnerGrid.squares[1][1];
      }
      if (playableInnerGrid.squares[0][1].player == player &&
          playableInnerGrid.squares[2][1].player == player) {
        return playableInnerGrid.squares[1][1];
      }
      if (playableInnerGrid.squares[0][2].player == player &&
          playableInnerGrid.squares[2][0].player == player) {
        return playableInnerGrid.squares[1][1];
      }
      if (playableInnerGrid.squares[0][0].player == player &&
          playableInnerGrid.squares[2][2].player == player) {
        return playableInnerGrid.squares[1][1];
      }
    }

    ///    ___         __x
    ///    xxx    OR   __x
    ///    ___         __x
    if (this.findSquareByPosition(playableSquares, Position(1, 2)) != null) {
      if (playableInnerGrid.squares[1][0].player == player &&
          playableInnerGrid.squares[1][1].player == player) {
        return playableInnerGrid.squares[1][2];
      }
      if (playableInnerGrid.squares[0][2].player == player &&
          playableInnerGrid.squares[2][2].player == player) {
        return playableInnerGrid.squares[1][2];
      }
    }

    ///    ___         x__          __x
    ///    ___    OR   x__    OR    _x_
    ///    xxx         x__          x__
    if (this.findSquareByPosition(playableSquares, Position(2, 0)) != null) {
      if (playableInnerGrid.squares[2][1].player == player &&
          playableInnerGrid.squares[2][2].player == player) {
        return playableInnerGrid.squares[2][0];
      }
      if (playableInnerGrid.squares[0][0].player == player &&
          playableInnerGrid.squares[1][0].player == player) {
        return playableInnerGrid.squares[2][0];
      }
      if (playableInnerGrid.squares[1][1].player == player &&
          playableInnerGrid.squares[0][2].player == player) {
        return playableInnerGrid.squares[2][0];
      }
    }

    ///    ___         _x_
    ///    ___    OR   _x_
    ///    xxx         _x_
    if (this.findSquareByPosition(playableSquares, Position(2, 1)) != null) {
      if (playableInnerGrid.squares[2][0].player == player &&
          playableInnerGrid.squares[2][2].player == player) {
        return playableInnerGrid.squares[2][1];
      }
      if (playableInnerGrid.squares[1][1].player == player &&
          playableInnerGrid.squares[0][1].player == player) {
        return playableInnerGrid.squares[2][1];
      }
    }

    ///    ___         __x          x__
    ///    ___    OR   __x    OR    _x_
    ///    xxx         __x          __x
    if (this.findSquareByPosition(playableSquares, Position(2, 2)) != null) {
      if (playableInnerGrid.squares[2][0].player == player &&
          playableInnerGrid.squares[2][1].player == player) {
        return playableInnerGrid.squares[2][2];
      }
      if (playableInnerGrid.squares[1][2].player == player &&
          playableInnerGrid.squares[0][2].player == player) {
        return playableInnerGrid.squares[2][2];
      }
      if (playableInnerGrid.squares[1][1].player == player &&
          playableInnerGrid.squares[0][0].player == player) {
        return playableInnerGrid.squares[2][2];
      }
    }

    return null;
  }
}
