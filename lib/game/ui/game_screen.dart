import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_no/game/bloc/game_bloc.dart';
import 'package:tic_tac_no/game/data/models/models.dart';
import 'package:tic_tac_no/game/ui/grid_widget.dart';
import 'package:tic_tac_no/game/ui/player_column.dart';
import 'package:confetti/confetti.dart';
import 'package:tic_tac_no/menu/ui/primary_button.dart';

class GameScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GameScreenState();
}

class GameScreenState extends State<GameScreen> {
  Grid _grid;
  List<Player> _players;
  Player _currentPlayer;
  Map<int, int> _score;

  // Confetti
  ConfettiController _confettiController;

  @override
  void initState() {
    this._grid = BlocProvider.of<GameBloc>(context).getGrid();
    this._players = BlocProvider.of<GameBloc>(context).players;
    this._currentPlayer = BlocProvider.of<GameBloc>(context).getCurrentPlayer();
    this._score = BlocProvider.of<GameBloc>(context).score;
    _confettiController = ConfettiController(duration: Duration(seconds: 10));
    super.initState();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameBloc, GameState>(
      listener: (context, state) {
        if (state is Ready) {
          setState(() {
            this._grid = state.grid;
            this._players = state.players;
            this._currentPlayer = state.currentPlayer;
            this._score = state.score;
          });
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 48, bottom: 16),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xff1E3C72), Color(0xff2A5298)],
              )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 120,
                    child: BlocBuilder<GameBloc, GameState>(
                      builder: (context, state) {
                        if (state is GameOver && state.winner != null) {
                          _confettiController.play();
                          return Center(
                            child: Column(
                              children: [
                                Text(
                                  '${state.winner.name}'.toUpperCase() +
                                      ' wins!'.toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Expanded(
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Container(
                                      padding: EdgeInsets.all(16),
                                      child: CustomPaint(
                                        painter: state.winner.symbol,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (state is GameOver && state.winner == null) {
                          return Center(
                            child: Text(
                              'Nobody wins 😲'.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          );
                        } else {
                          return Row(
                            children: [
                              Expanded(
                                child: PlayerColumn(
                                  player: _players[0],
                                  isPlayerTurn: _players[0] == _currentPlayer,
                                ),
                              ),
                              Row(
                                children: [
                                  // Taken directly from: https://api.flutter.dev/flutter/widgets/AnimatedSwitcher-class.html
                                  AnimatedSwitcher(
                                    duration: Duration(milliseconds: 500),
                                    transitionBuilder: (child, animation) {
                                      return ScaleTransition(
                                        child: child,
                                        scale: animation,
                                      );
                                    },
                                    child: Text(
                                      '${_score[_players[0].id]}',
                                      key:
                                          ValueKey<int>(_score[_players[0].id]),
                                      style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                    ' : ',
                                    style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  AnimatedSwitcher(
                                    duration: Duration(milliseconds: 500),
                                    transitionBuilder: (child, animation) {
                                      return ScaleTransition(
                                        child: child,
                                        scale: animation,
                                      );
                                    },
                                    child: Text(
                                      '${_score[_players[1].id]}',
                                      key:
                                          ValueKey<int>(_score[_players[1].id]),
                                      style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: PlayerColumn(
                                  player: _players[1],
                                  isPlayerTurn: _players[1] == _currentPlayer,
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: GridWidget(
                      grid: this._grid,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: IconButton(
                      onPressed: () => showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 24, horizontal: 24),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xff012E44),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Are you sure?'),
                              SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).popUntil((route) =>
                                          route.settings.name == '/');
                                      context.read<GameBloc>().add(Reset());
                                    },
                                    child: Container(
                                      height: 48,
                                      width: 96,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        color: Color(0xffFF5F6D),
                                      ),
                                      child: Center(
                                        child: Text('QUIT'),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => Navigator.of(context).pop(),
                                    child: Container(
                                      height: 48,
                                      width: 96,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        color: Color(0xffFF5F6D),
                                      ),
                                      child: Center(
                                        child: Text('CANCEL'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      icon: Icon(
                        Icons.arrow_back,
                        size: 30,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    // child: IconButton(
                    //   iconSize: 20,
                    //   icon: Icon(Icons.party_mode),
                    //   onPressed: () {
                    //     _confettiController.play();
                    //   },
                    // ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirection: pi,
                  maxBlastForce: 7,
                  minBlastForce: 2,
                  emissionFrequency: 0.2,
                  numberOfParticles: 3,
                  gravity: 0.3,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirection: 0,
                  maxBlastForce: 7,
                  minBlastForce: 2,
                  emissionFrequency: 0.2,
                  numberOfParticles: 3,
                  gravity: 0.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
