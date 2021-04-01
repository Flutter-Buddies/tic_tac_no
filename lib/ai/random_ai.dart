import 'dart:math';

import 'package:tic_tac_no/ai/ai.dart';
import 'package:tic_tac_no/game/data/models/grid.dart';
import 'package:tic_tac_no/game/data/models/square.dart';

class RandomAI extends AI {
  @override
  Square makeMove(Grid grid) {
    final playableInnerGrid = this.getPlayableInnerGrid(grid);

    final playableSquares = this.getPlayableSquares(playableInnerGrid);

    final random = Random().nextInt(playableSquares.length);
    return playableSquares[random];
  }
}
