import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tic_tac_no/ai/ai.dart';
import 'package:tic_tac_no/ai/human_ai.dart';
import 'package:tic_tac_no/ai/random_ai.dart';
import 'package:tic_tac_no/ai/winner_ai.dart';
import 'package:tic_tac_no/game/data/models/models.dart';
import 'package:tic_tac_no/judge/judge.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  List<Player> _players;
  Grid _grid;

  Judge _judge;
  AI _ai;

  GameBloc() : super(Loading()) {
    this._grid = Grid();
    this._judge = Judge(
      grid: this._grid,
    );
  }

  Grid getGrid() {
    return this._judge.getGrid();
  }

  Player getCurrentPlayer() {
    return this._judge.getCurrentPlayer();
  }

  List<Player> get players => _players;

  Map<int, int> get score => _judge.score;

  @override
  Stream<GameState> mapEventToState(
    GameEvent event,
  ) async* {
    if (event is SetPlayers) {
      yield Loading();
      _players = [event.player1, event.player2];
      _updateAI(event.player2);
      _judge.updatePlayers(_players);
      yield Ready(
        grid: this._judge.getGrid(),
        players: this._players,
        currentPlayer: this._judge.getCurrentPlayer(),
        score: _judge.score,
        winner: this._judge.getWinner(),
      );
    }
    if (event is LoadGame) {
      yield Ready(
        grid: this._judge.getGrid(),
        players: this._players,
        currentPlayer: this._judge.getCurrentPlayer(),
        score: _judge.score,
        winner: this._judge.getWinner(),
      );
    }
    if (event is SquareTapped) {
      if (this.state is! Ready) {
        return;
      }
      yield JudgeThinking();
      this._judge.updateGame(event.square);
      if (this._judge.getIsGameOver()) {
        yield GameOver(
          winner: this._judge.getWinner(),
        );
      } else {
        yield Ready(
          grid: this._judge.getGrid(),
          players: this._players,
          currentPlayer: this._judge.getCurrentPlayer(),
          score: _judge.score,
          winner: this._judge.getWinner(),
        );
        if (this._judge.getCurrentPlayer().type == PlayerType.ai) {
          yield AIThinking();
          await Future.delayed(Duration(milliseconds: 400));
          final Square move = this._ai.makeMove(this._judge.getGrid());
          yield Ready(
            grid: this._judge.getGrid(),
            players: this._players,
            currentPlayer: this._judge.getCurrentPlayer(),
            score: _judge.score,
            winner: this._judge.getWinner(),
          );
          this.add(SquareTapped(square: move));
        }
      }
    }
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
