import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_no/game/bloc/game_bloc.dart';
import 'package:tic_tac_no/game/data/models/player.dart';

class PlayerColumn extends StatelessWidget {
  final Player player;
  final bool isPlayerTurn;
  PlayerColumn({this.player, this.isPlayerTurn});
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isPlayerTurn ? 1.0 : 0.5,
      child: Container(
        child: Column(
          children: [
            Text(
              player.name.toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    margin: EdgeInsets.all(16),
                    child: CustomPaint(
                      painter: player.symbol,
                    ),
                  ),
                ),
              ),
            ),
            Opacity(
              opacity: isPlayerTurn ? 1.0 : 0.0,
              child: BlocBuilder<GameBloc, GameState>(
                builder: (context, state) {
                  if (state is AIThinking) {
                    return Container(
                      height: 20,
                      child: Text(
                        'Thinking...',
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 6.0),
                      child: Container(
                        width: 70,
                        height: 8,
                        color: player.color,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
