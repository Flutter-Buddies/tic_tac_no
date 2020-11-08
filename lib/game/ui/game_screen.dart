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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
            SizedBox(height: 16),
            Row(
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
            SizedBox(height: 16),
            GridWidget(
              grid: this._grid,
            )
          ],
        ),
      ),
    );
  }
}
