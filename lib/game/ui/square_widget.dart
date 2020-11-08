import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_no/game/bloc/game_bloc.dart';
import 'package:tic_tac_no/game/data/models/square.dart';

class SquareWidget extends StatelessWidget {
  final Square square;

  SquareWidget({this.square});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => BlocProvider.of<GameBloc>(context)
          .add(SquareTapped(square: this.square)),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: _getColor(),
          border: Border.all(
            color: Colors.black,
            width: 1.0,
          ),
        ),
      ),
    );
  }

  Color _getColor() {
    if (this.square.player == null) {
      return Colors.transparent;
    }
    return this.square.player.color;
  }
}
