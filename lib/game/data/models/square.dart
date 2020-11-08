import 'package:flutter/material.dart';
import 'package:tic_tac_no/game/data/models/models.dart';
import 'package:tic_tac_no/game/data/models/position.dart';

class Square {
  final InnerGrid parentInnerGrid;
  final Position position;
  Player player;

  Square({
    @required this.parentInnerGrid,
    @required this.position,
    this.player,
  });

  @override
  String toString() {
    return '+';
  }
}
