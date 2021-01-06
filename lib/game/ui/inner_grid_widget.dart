import 'package:flutter/material.dart';
import 'package:tic_tac_no/game/data/models/inner_grid.dart';
import 'package:tic_tac_no/game/ui/square_widget.dart';

class InnerGridWidget extends StatefulWidget {
  final InnerGrid innerGrid;

  InnerGridWidget({
    @required this.innerGrid,
  });

  @override
  _InnerGridWidgetState createState() => _InnerGridWidgetState();
}

class _InnerGridWidgetState extends State<InnerGridWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: _decideBackgroundColor(),
      ),
      curve: Curves.easeIn,
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

  // Background colour details
  Color _decideBackgroundColor() {
    if (this.widget.innerGrid.winner == null) {
      return Colors.white.withOpacity(0.1);
    }
    return this.widget.innerGrid.winner.color.withOpacity(0.5);
  }

  // Borderside details
  final Color _isPlayableColor = Color(0xff63F4F0);
  final Color _isNotPlayableColor = Colors.white;

  BorderSide _buildBorderSide() {
    return BorderSide(
      color: this.widget.innerGrid.isPlayable
          ? _isPlayableColor
          : _isNotPlayableColor,
      width: this.widget.innerGrid.isPlayable ? 3.0 : 1.0,
    );
  }

  List<SquareWidget> _buildSquareWidgets(int row) {
    return this
        .widget
        .innerGrid
        .squares[row]
        .map((square) => SquareWidget(square: square))
        .toList();
  }
}
