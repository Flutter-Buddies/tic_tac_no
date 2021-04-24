import 'package:tic_tac_no/game/data/models/models.dart';
import 'package:tic_tac_no/game/data/models/position.dart';

class Square {
  Square({
    required this.parentInnerGrid,
    required this.position,
    this.player,
  });

  final InnerGrid parentInnerGrid;
  final Position position;
  Player? player;

  @override
  String toString() {
    return '+';
  }
}
