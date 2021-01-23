part of 'game_bloc.dart';

@immutable
abstract class GameEvent {}

class SetPlayers extends GameEvent {
  final Player player1;
  final Player player2;

  SetPlayers({
    @required this.player1,
    @required this.player2,
  });
}

class LoadGame extends GameEvent {}

class SquareTapped extends GameEvent {
  final Square square;

  SquareTapped({this.square});
}

class AIMove extends GameEvent {}

class Reset extends GameEvent {}
