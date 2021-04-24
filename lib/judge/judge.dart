import 'package:tic_tac_no/game/data/models/grid.dart';
import 'package:tic_tac_no/game/data/models/models.dart';
import 'package:tic_tac_no/game/data/models/player.dart';
import 'package:tic_tac_no/game/data/models/square.dart';
import 'package:tic_tac_no/game/data/models/winning_positions.dart';
import 'package:tic_tac_no/utils/audio.dart';

class Judge {
  Judge({
    this.players,
    required Grid grid,
  }) {
    this._currentPlayer = this.players != null ? this.players![0] : null;
    this._grid = grid;
    if (this.players != null && this.players!.length >= 2) {
      _score = {
        players![0].id: 0,
        players![1].id: 0,
      };
    }
  }

  List<Player>? players;
  late Grid _grid;
  Player? _currentPlayer;
  Map<int, int>? _score;
  Player? _winner;
  bool _isGameOver = false;
  WinningPositions? _winningPositions;

  Grid getGrid() => this._grid;

  Player? getCurrentPlayer() => this._currentPlayer;

  Map<int, int>? get score => _score;

  Player? getWinner() => this._winner;

  bool getIsGameOver() => this._isGameOver;

  WinningPositions? getWinningPositions() => this._winningPositions;

  void updatePlayers(List<Player> players) {
    this.players = players;
    this._currentPlayer = this.players != null && this.players!.isNotEmpty
        ? this.players![0]
        : null;
    _score ??= {
      players[0].id: 0,
      players[1].id: 0,
    };
    _updateGrid();
  }

  void _updateGrid() {
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        final winner = this._grid.innerGrids[i][j].winner;
        if (winner != null) {
          this._grid.innerGrids[i][j].winner =
              this.players!.firstWhere((player) => player.id == winner.id);
        }
        for (var k = 0; k < 3; k++) {
          for (var l = 0; l < 3; l++) {
            if (this._grid.innerGrids[i][j].squares[k][l].player != null) {
              final oldPlayer =
                  this._grid.innerGrids[i][j].squares[k][l].player;
              this._grid.innerGrids[i][j].squares[k][l].player = this
                  .players!
                  .firstWhere((player) => player.id == oldPlayer?.id);
            }
          }
        }
      }
    }
  }

  void updateGame(Square tappedSquare, GameAudio audio) {
    // check if move can be made at this square
    if (tappedSquare.parentInnerGrid.isPlayable == false) {
      return;
    }
    if (tappedSquare.player != null) {
      return;
    }

    audio.playSound(GameSounds.PlacingPiece);

    final innerGridPosition = tappedSquare.parentInnerGrid.position;
    // update square's player (occupant)
    _grid
        .innerGrids[innerGridPosition.x][innerGridPosition.y]
        .squares[tappedSquare.position.x][tappedSquare.position.y]
        .player = this._currentPlayer;

    // mark all inner grids unplayable
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        this._grid.innerGrids[i][j].isPlayable = false;
      }
    }

    // check did current player win
    if (tappedSquare.parentInnerGrid.winner == null) {
      if (this._didWin(tappedSquare.parentInnerGrid)) {
        _grid.innerGrids[innerGridPosition.x][innerGridPosition.y].winner =
            this._currentPlayer;
        if (_score != null) {
          final currentPlayerId = _currentPlayer?.id;
          if (currentPlayerId != null && _score![currentPlayerId] != null) {
            _score![currentPlayerId] = _score![currentPlayerId]! + 1;
          }
        }
        audio.playSound(GameSounds.InnerGridWin);
        // chick did current player win entire game
        if (this._didWinGame()) {
          this._isGameOver = true;
          this._winner = this._currentPlayer;
        }
      }
    }

    // mark next playable innerGrid
    if (_grid.innerGrids[tappedSquare.position.x][tappedSquare.position.y]
        .hasRoom()) {
      _grid.innerGrids[tappedSquare.position.x][tappedSquare.position.y]
          .isPlayable = true;
    } else {
      // choose random
      final position = this._grid.getRandomInnerGridPositionThatHasRoom();
      if (position.x != -1) {
        _grid.innerGrids[position.x][position.y].isPlayable = true;
      } else {
        // end game as a tie
        this._isGameOver = true;

        if (_score != null) {
          final player1Score = _score![players?[0].id];
          final player2Score = _score![players?[1].id];

          if (player1Score != null && player2Score != null) {
            if (player1Score > player2Score) {
              this._winner = players![0];
            } else if (player1Score < player2Score) {
              this._winner = players![1];
            } else {
              this._winner = null;
            }
          }
        }
      }
    }

    // change current player
    if (this.players != null) {
      this._currentPlayer = this
          .players!
          .firstWhere((player) => player.id != this._currentPlayer?.id);
    }
  }

  bool _didWin(InnerGrid innerGrid) {
    ///    xxx         ___          ___
    ///    ___    OR   xxx    OR    ___
    ///    ___         ___          xxx
    for (var i = 0; i < 3; i++) {
      if (innerGrid.squares[i][0].player == this._currentPlayer &&
          innerGrid.squares[i][1].player == this._currentPlayer &&
          innerGrid.squares[i][2].player == this._currentPlayer) {
        return true;
      }
    }

    ///    x__         _x_          __x
    ///    x__    OR   _x_    OR    __x
    ///    x__         _x_          __x
    for (var i = 0; i < 3; i++) {
      if (innerGrid.squares[0][i].player == this._currentPlayer &&
          innerGrid.squares[1][i].player == this._currentPlayer &&
          innerGrid.squares[2][i].player == this._currentPlayer) {
        return true;
      }
    }

    ///    x__
    ///    _x_
    ///    __x
    if (innerGrid.squares[0][0].player == this._currentPlayer &&
        innerGrid.squares[1][1].player == this._currentPlayer &&
        innerGrid.squares[2][2].player == this._currentPlayer) {
      return true;
    }

    ///    __x
    ///    _x_
    ///    x__
    if (innerGrid.squares[0][2].player == this._currentPlayer &&
        innerGrid.squares[1][1].player == this._currentPlayer &&
        innerGrid.squares[2][0].player == this._currentPlayer) {
      return true;
    }

    return false;
  }

  bool _didWinGame() {
    ///    xxx         ___          ___
    ///    ___    OR   xxx    OR    ___
    ///    ___         ___          xxx
    for (var i = 0; i < 3; i++) {
      if (this._grid.innerGrids[i][0].winner == this._currentPlayer &&
          this._grid.innerGrids[i][1].winner == this._currentPlayer &&
          this._grid.innerGrids[i][2].winner == this._currentPlayer) {
        this._winningPositions = WinningPositions(
          lineType: LineType.Horizontal,
          thirdPosition: i + 1,
        );
        return true;
      }
    }

    ///    x__         _x_          __x
    ///    x__    OR   _x_    OR    __x
    ///    x__         _x_          __x
    for (var i = 0; i < 3; i++) {
      if (this._grid.innerGrids[0][i].winner == this._currentPlayer &&
          this._grid.innerGrids[1][i].winner == this._currentPlayer &&
          this._grid.innerGrids[2][i].winner == this._currentPlayer) {
        this._winningPositions = WinningPositions(
          lineType: LineType.Veritical,
          thirdPosition: i + 1,
        );
        return true;
      }
    }

    ///    x__
    ///    _x_
    ///    __x
    if (this._grid.innerGrids[0][0].winner == this._currentPlayer &&
        this._grid.innerGrids[1][1].winner == this._currentPlayer &&
        this._grid.innerGrids[2][2].winner == this._currentPlayer) {
      this._winningPositions = const WinningPositions(
        lineType: LineType.DiagonalBack,
        thirdPosition: 0,
      );
      return true;
    }

    ///    __x
    ///    _x_
    ///    x__
    if (this._grid.innerGrids[0][2].winner == this._currentPlayer &&
        this._grid.innerGrids[1][1].winner == this._currentPlayer &&
        this._grid.innerGrids[2][0].winner == this._currentPlayer) {
      this._winningPositions = const WinningPositions(
        lineType: LineType.DiagonalForward,
        thirdPosition: 0,
      );
      return true;
    }

    return false;
  }
}
