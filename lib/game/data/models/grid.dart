import 'package:tic_tac_no/game/data/models/inner_grid.dart';
import 'package:tic_tac_no/game/data/models/position.dart';

class Grid {
  Grid() {
    this.innerGrids = [];
    for (var i = 0; i < 3; i++) {
      this.innerGrids.add([]);
      for (var j = 0; j < 3; j++) {
        this.innerGrids[i].add(InnerGrid(position: Position(i, j)));
      }
    }
  }

  late List<List<InnerGrid>> innerGrids;

  Position getRandomInnerGridPositionThatHasRoom() {
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        if (this.innerGrids[i][j].hasRoom()) {
          return this.innerGrids[i][j].position;
        }
      }
    }
    return const Position(-1, -1);
  }

  @override
  String toString() {
    final strBuffer = StringBuffer();
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        strBuffer.write(this.innerGrids[i][j].toString());
      }
      strBuffer.write('\n');
    }
    return strBuffer.toString();
  }
}
