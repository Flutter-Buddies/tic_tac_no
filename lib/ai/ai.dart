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
}
