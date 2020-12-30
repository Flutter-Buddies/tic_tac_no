part of 'game_bloc.dart';

@immutable
abstract class GameState {}

class Loading extends GameState {}

class AIThinking extends GameState {}

class JudgeThinking extends GameState {}

class Ready extends GameState {
  final Grid grid;
  final List<Player> players;
  final Player currentPlayer;
  final Map<int, int> score;
  final Player winner;

  Ready({
    @required this.grid,
    @required this.players,
    @required this.currentPlayer,
    @required this.score,
    @required this.winner,
  });
}

class GameOver extends GameState {
  final Player winner;

  GameOver({this.winner});
}
