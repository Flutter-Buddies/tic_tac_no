import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tic_tac_no/ai/ai.dart';
import 'package:tic_tac_no/ai/random_ai.dart';
import 'package:tic_tac_no/ai/stupid_ai.dart';
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
    this._players = this._createPlayers();
    this._grid = Grid();

    this._judge = Judge(
      players: this._players,
      grid: this._grid,
    );

    this._ai = StupidAI(this._players[1]);
  }

  Grid getGrid() {
    return this._judge.getGrid();
  }

  Player getCurrentPlayer() {
    return this._judge.getCurrentPlayer();
  }

  @override
  Stream<GameState> mapEventToState(
    GameEvent event,
  ) async* {
    if (event is LoadGame) {
      yield Ready(
        grid: this._judge.getGrid(),
        currentPlayer: this._judge.getCurrentPlayer(),
        winner: this._judge.getWinner(),
      );
    }
    if (event is SquareTapped) {
      yield JudgeThinking();
      this._judge.updateGame(event.square);
      if (this._judge.getIsGameOver()) {
        yield GameOver(
          winner: this._judge.getWinner(),
        );
      } else {
        yield Ready(
          grid: this._judge.getGrid(),
          currentPlayer: this._judge.getCurrentPlayer(),
          winner: this._judge.getWinner(),
        );
        yield AIThinking();
        await Future.delayed(Duration(milliseconds: 400));
        final Square move = this._ai.makeMove(this._judge.getGrid());
        yield JudgeThinking();
        this._judge.updateGame(move);

        yield Ready(
          grid: this._judge.getGrid(),
          currentPlayer: this._judge.getCurrentPlayer(),
          winner: this._judge.getWinner(),
        );
      }
    }
  }

  List<Player> _createPlayers() {
    return [
      Player(name: 'Player 1', color: Colors.red),
      Player(name: 'Player 2', color: Colors.blue),
    ];
  }
}
