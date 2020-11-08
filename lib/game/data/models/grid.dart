import 'package:tic_tac_no/game/data/models/inner_grid.dart';
import 'package:tic_tac_no/game/data/models/position.dart';

class Grid {
  List<List<InnerGrid>> innerGrids;
  InnerGrid playableGrid;

  Grid() {
    this.innerGrids = [];
    for (int i = 0; i < 3; i++) {
      this.innerGrids.add([]);
      for (int j = 0; j < 3; j++) {
        this.innerGrids[i].add(InnerGrid(position: Position(i, j)));
      }
    }
  }

  Position getRandomInnerGridPositionThatHasRoom() {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (this.innerGrids[i][j].hasRoom()) {
          return this.innerGrids[i][j].position;
        }
      }
    }
    return Position(-1, -1);
  }

  @override
  String toString() {
    String result = '';
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        result += this.innerGrids[i][j].toString();
      }
      result += "\n";
    }
    return result;
  }
}
