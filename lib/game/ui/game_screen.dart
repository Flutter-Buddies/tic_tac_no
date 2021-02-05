import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_no/game/bloc/game_bloc.dart';
import 'package:tic_tac_no/game/data/models/models.dart';
import 'package:tic_tac_no/game/ui/grid_widget.dart';
import 'package:tic_tac_no/game/ui/player_column.dart';
import 'package:confetti/confetti.dart';

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

  Future<bool> backFunction() async {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xff012E44),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Are you sure you\'d like to quit?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 4,
            ),
            Text('All progress will be lost'),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .popUntil((route) => route.settings.name == '/');
                    context.read<GameBloc>().add(Reset());
                  },
                  child: Container(
                    height: 48,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Color(0xffFF5F6D),
                    ),
                    child: Center(
                      child: Text(
                        'QUIT GAME',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    height: 48,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xff2A5298),
                    ),
                    child: Center(
                      child: Text(
                        'RETURN TO GAME',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
      child: WillPopScope(
        onWillPop: () => backFunction(),
        child: SafeArea(
          child: Scaffold(
            body: Stack(
              children: [
                //* Background
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 12, bottom: 16),
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
                      //* Player info section
                      // Wrapping with expanded because this is the section that will resize based on screen size
                      // and we want to to scale vertically
                      Expanded(
                        child: BlocBuilder<GameBloc, GameState>(
                          builder: (context, state) {
                            //* Game end state
                            if (state is GameOver && state.winner != null) {
                              _confettiController.play();
                              return Center(
                                child: Column(
                                  children: [
                                    Text(
                                      '${state.winner.name}'.toUpperCase() +
                                          // Use correct grammar if the player name = "You"
                                          (state.winner.type == PlayerType.me
                                              ? ' win!'.toUpperCase()
                                              : ' wins!'.toUpperCase()),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: LayoutBuilder(
                                          builder: (context, constraints) {
                                            return Container(
                                              padding: EdgeInsets.all(
                                                  constraints.maxHeight > 160
                                                      ? 48
                                                      : 12),
                                              child: CustomPaint(
                                                painter: state.winner.symbol,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                              //* Game draw state
                            } else if (state is GameOver &&
                                state.winner == null) {
                              return Center(
                                child: Text(
                                  'Nobody wins 😲'.toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                              //* Game is active state
                            } else {
                              return Row(
                                // We want the content to be aligned in the center vertically
                                crossAxisAlignment: CrossAxisAlignment.center,
                                // The score text will remain a constant size so will not be wrapped in Expanded
                                // The player name, piece and turn info will be the thing that scales
                                children: [
                                  // Wrapped in expanded to scale
                                  // Currently taking the max width it can
                                  Expanded(
                                    child: PlayerColumn(
                                      player: _players[0],
                                      isPlayerTurn:
                                          _players[0] == _currentPlayer,
                                    ),
                                  ),
                                  // Score info remains constant size
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
                                  // Wrapped in expanded to scale
                                  Expanded(
                                    child: PlayerColumn(
                                      player: _players[1],
                                      isPlayerTurn:
                                          _players[1] == _currentPlayer,
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ),
                      //* Grid
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: GridWidget(
                          grid: this._grid,
                        ),
                      ),
                      //* Button to go back
                      SizedBox(
                        height: 30,
                        child: IconButton(
                          onPressed: () => backFunction(),
                          icon: Icon(
                            Icons.arrow_back,
                            size: 30,
                          ),
                        ),
                      ),
                      //? For some reason this has to be here to have the confetti work
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
                //* Confetti right
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
                      colors: [
                        Color(0xff1E3C72),
                        Colors.white,
                        Color(0xffFF5F6D),
                        Color(0xffFFC371),
                        Color(0xffE33E49),
                        Color(0xff9B00B5),
                        Color(0xff9534E1),
                        Color(0xff009E95),
                      ],
                    ),
                  ),
                ),
                //* Confetti left
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
                      colors: [
                        Color(0xff1E3C72),
                        Colors.white,
                        Color(0xffFF5F6D),
                        Color(0xffFFC371),
                        Color(0xffE33E49),
                        Color(0xff9B00B5),
                        Color(0xff9534E1),
                        Color(0xff009E95),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
