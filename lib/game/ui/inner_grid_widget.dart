import 'package:flutter/material.dart';
import 'package:tic_tac_no/game/data/models/inner_grid.dart';
import 'package:tic_tac_no/game/ui/square_widget.dart';

class InnerGridWidget extends StatelessWidget {
  final InnerGrid innerGrid;

  InnerGridWidget({
    @required this.innerGrid,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _decideBackgroundColor(),
      child: Table(
        border: TableBorder(
          top: _buildBorderSide(),
          bottom: _buildBorderSide(),
          left: _buildBorderSide(),
          right: _buildBorderSide(),
        ),
        children: [
          TableRow(
            children: _buildSquareWidgets(0),
          ),
          TableRow(
            children: _buildSquareWidgets(1),
          ),
          TableRow(
            children: _buildSquareWidgets(2),
          ),
        ],
      ),
    );
  }

  Color _decideBackgroundColor() {
    if (this.innerGrid.winner == null) {
      return Colors.transparent;
    }
    return this.innerGrid.winner.color.withOpacity(0.4);
  }

  BorderSide _buildBorderSide() {
    return BorderSide(
      color: this.innerGrid.isPlayable ? Colors.yellow : Colors.black,
      width: 2.0,
    );
  }

  List<SquareWidget> _buildSquareWidgets(int row) {
    return this
        .innerGrid
        .squares[row]
        .map((square) => SquareWidget(square: square))
        .toList();
  }
}
