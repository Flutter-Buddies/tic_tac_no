import 'package:meta/meta.dart';
import 'package:tic_tac_no/game/data/models/player.dart';
import 'package:tic_tac_no/game/data/models/position.dart';
import 'package:tic_tac_no/game/data/models/square.dart';

class InnerGrid {
  final Position position;
  List<List<Square>> squares;
  bool isPlayable = true;
  Player winner;

  InnerGrid({@required this.position}) {
    this.squares = [];
    for (int i = 0; i < 3; i++) {
      this.squares.add([]);
      for (int j = 0; j < 3; j++) {
        this.squares[i].add(Square(
              parentInnerGrid: this,
              position: Position(i, j),
            ));
      }
    }
  }

  bool hasRoom() {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (this.squares[i][j].player == null) {
          return true;
        }
      }
    }
    return false;
  }

  @override
  String toString() {
    String result = '';
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        result += this.squares[i][j].toString();
      }
      result += "\n";
    }
    return result;
  }
}
