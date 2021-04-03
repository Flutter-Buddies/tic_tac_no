import 'package:meta/meta.dart';
import 'package:tic_tac_no/game/data/models/player.dart';
import 'package:tic_tac_no/game/data/models/position.dart';
import 'package:tic_tac_no/game/data/models/square.dart';

class InnerGrid {
  InnerGrid({@required this.position}) {
    this.squares = [];
    for (var i = 0; i < 3; i++) {
      this.squares.add([]);
      for (var j = 0; j < 3; j++) {
        this.squares[i].add(Square(
              parentInnerGrid: this,
              position: Position(i, j),
            ));
      }
    }
  }

  final Position position;
  List<List<Square>> squares;
  bool isPlayable = true;
  Player winner;

  bool hasRoom() {
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        if (this.squares[i][j].player == null) {
          return true;
        }
      }
    }
    return false;
  }

  @override
  String toString() {
    final strBuffer = StringBuffer();
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        strBuffer.write(this.squares[i][j].toString());
      }
      strBuffer.write('\n');
    }
    return strBuffer.toString();
  }
}
