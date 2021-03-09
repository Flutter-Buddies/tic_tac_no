import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tic_tac_no/ai/ai.dart';
import 'package:tic_tac_no/ai/human_ai.dart';
import 'package:tic_tac_no/ai/random_ai.dart';
import 'package:tic_tac_no/ai/winner_ai.dart';
import 'package:tic_tac_no/game/data/models/models.dart';
import 'package:tic_tac_no/game/data/models/winning_positions.dart';
import 'package:tic_tac_no/judge/judge.dart';
import 'package:tic_tac_no/utils/audio.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(Loading()) {
    this._grid = Grid();
    this._judge = Judge(
      grid: this._grid,
    );
  }

  List<Player> _players;
  Grid _grid;

  Judge _judge;
  AI _ai;

  GameAudio _audio = GameAudio()..preloadSounds();

  Grid getGrid() {
    return this._judge.getGrid();
  }

  Player getCurrentPlayer() {
    return this._judge.getCurrentPlayer();
  }

  List<Player> get players => _players;

  Map<int, int> get score => _judge.score;

  @override
  Stream<GameState> mapEventToState(GameEvent event) async* {
    if (event is SetPlayers) yield* _mapSetPlayersToState(event);
    if (event is LoadGame) yield* _readyState();
    if (event is SquareTapped) {
      if (this.state is! Ready) return;
      yield* _mapSquareTappedToState(event);
    }
    if (event is Reset) yield* _mapResetToState();
  }

  Stream<GameState> _mapSetPlayersToState(SetPlayers event) async* {
    yield Loading();
    _players = [event.player1, event.player2];
    _updateAI(event.player2);
    _judge.updatePlayers(_players);
    yield* _readyState();
  }

  Stream<GameState> _readyState() async* {
    yield Ready(
      grid: this._judge.getGrid(),
      players: this._players,
      currentPlayer: this._judge.getCurrentPlayer(),
      score: _judge.score,
      winner: this._judge.getWinner(),
    );
  }

  Stream<GameState> _mapSquareTappedToState(SquareTapped event) async* {
    yield JudgeThinking();
    this._judge.updateGame(event.square, _audio);
    if (this._judge.getIsGameOver()) {
      yield* _readyState();
      yield GameOver(
        winner: this._judge.getWinner(),
        winningPositions: this._judge.getWinningPositions(),
      );
      if (this._judge.getWinner().type == PlayerType.ai ||
          this._judge.getWinner().type == PlayerType.onlineFriend) {
        _audio.playSound(GameSounds.GameLost);
      } else {
        _audio.playSound(GameSounds.GameWon);
      }
    } else {
      yield* _readyState();
      if (this._judge.getCurrentPlayer().type == PlayerType.ai) {
        _updateAI(_judge.getCurrentPlayer());
        yield AIThinking();
        await Future.delayed(
            Duration(milliseconds: 200 + Random().nextInt(1000)));
        final Square move = this._ai.makeMove(this._judge.getGrid());
        yield* _readyState();
        this.add(SquareTapped(square: move));
      }
    }
  }

  Stream<GameState> _mapResetToState() async* {
    this._grid = Grid();
    this._judge = Judge(
      grid: this._grid,
      players: this._players,
    );
    yield* _readyState();
  }

  void _updateAI(Player player) {
    if (player.type != PlayerType.ai) {
      _ai = null;
      return;
    }
    switch (player.aiStrength) {
      case 0:
        _ai = RandomAI();
        break;
      case 1:
        _ai = WinnerAI(player);
        break;
      case 2:
        _ai = HumanAI(player, _players[0]);
        break;
      default:
        _ai = RandomAI();
        break;
    }
  }
}
