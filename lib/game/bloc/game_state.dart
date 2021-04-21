part of 'game_bloc.dart';

@immutable
abstract class GameState {}

class Loading extends GameState {}

class AIThinking extends GameState {}

class JudgeThinking extends GameState {}

class Ready extends GameState {
  Ready({
    required this.grid,
    this.players,
    this.currentPlayer,
    this.score,
    this.winner,
  });

  final Grid grid;
  final List<Player>? players;
  final Player? currentPlayer;
  final Map<int, int>? score;
  final Player? winner;
}

class GameOver extends GameState {
  GameOver({
    this.winner,
    this.winningPositions,
  });

  final Player? winner;
  final WinningPositions? winningPositions;
}
