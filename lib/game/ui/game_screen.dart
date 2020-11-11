import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_no/game/bloc/game_bloc.dart';
import 'package:tic_tac_no/game/data/models/models.dart';
import 'package:tic_tac_no/game/ui/grid_widget.dart';

class GameScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GameScreenState();
}

class GameScreenState extends State<GameScreen> {
  Grid _grid;
  Player _currentPlayer;

  @override
  void initState() {
    this._grid = BlocProvider.of<GameBloc>(context).getGrid();
    this._currentPlayer = BlocProvider.of<GameBloc>(context).getCurrentPlayer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameBloc, GameState>(
      listener: (context, state) {
        if (state is Ready) {
          setState(() {
            this._grid = state.grid;
            this._currentPlayer = state.currentPlayer;
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.green,
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 0,
                child:
                    BlocBuilder<GameBloc, GameState>(builder: (context, state) {
                  if (state is GameOver) {
                    if (state.winner == null) {
                      return Text('TIE!');
                    } else {
                      return Text('Winner is ${state.winner.name}!');
                    }
                  }
                  return SizedBox.shrink();
                }),
              ),
              Positioned(
                top: 0,
                child:
                    BlocBuilder<GameBloc, GameState>(builder: (context, state) {
                  if (state is AIThinking) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('AI is thinking...'),
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    );
                  }
                  return SizedBox.shrink();
                }),
              ),
              Positioned(
                top: 32,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('TURN: ${this._currentPlayer.name}'),
                    Container(
                      width: 20,
                      height: 20,
                      color: this._currentPlayer.color,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 64.0),
                child: GridWidget(
                  grid: this._grid,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
