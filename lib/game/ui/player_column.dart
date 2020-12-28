import 'package:flutter/material.dart';
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
            SizedBox(
              height: 16,
            ),
            Container(
              margin: EdgeInsets.all(8),
              height: 80,
              width: 80,
              child: CustomPaint(
                painter: player.symbol,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Opacity(
              opacity: isPlayerTurn ? 1.0 : 0.0,
              child: Container(
                height: 8,
                width: 100,
                color: player.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
