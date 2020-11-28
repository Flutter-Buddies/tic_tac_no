import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum PlayerType { me, ai, friend, onlineFriend }

class Player extends Equatable {
  final int id;
  final String name;
  final Color color;
  final CustomPainter symbol;
  final PlayerType type;
  final int aiStrength;

  Player({
    this.id,
    this.name: 'No name',
    @required this.color,
    @required this.symbol,
    @required this.type,
    this.aiStrength,
  });

  @override
  List<Object> get props => [id, name, color, symbol, type, aiStrength];

  @override
  String toString() {
    return 'Player $id, piece $symbol';
  }
}
