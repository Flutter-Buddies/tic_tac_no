part of 'game_bloc.dart';

@immutable
abstract class GameEvent {}

class SetPlayers extends GameEvent {
  SetPlayers({
    required this.player1,
    required this.player2,
  });

  final Player player1;
  final Player player2;
}

class LoadGame extends GameEvent {}

class SquareTapped extends GameEvent {
  SquareTapped({
    required this.square,
  });

  final Square square;
}

class AIMove extends GameEvent {}

class Reset extends GameEvent {}
