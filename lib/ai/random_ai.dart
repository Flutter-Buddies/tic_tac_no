import 'dart:math';

import 'package:tic_tac_no/ai/ai.dart';
import 'package:tic_tac_no/game/data/models/grid.dart';
import 'package:tic_tac_no/game/data/models/inner_grid.dart';
import 'package:tic_tac_no/game/data/models/square.dart';

class RandomAI extends AI {
  Square makeMove(Grid grid) {
    InnerGrid playableInnerGrid = this.getPlayableInnerGrid(grid);

    List<Square> playableSquares = this.getPlayableSquares(playableInnerGrid);

    final int random = Random().nextInt(playableSquares.length);
    return playableSquares[random];
  }
}
