import 'package:flutter/material.dart';
import 'package:tic_tac_no/game/data/models/grid.dart';
import 'package:tic_tac_no/game/ui/inner_grid_widget.dart';

class GridWidget extends StatelessWidget {
  final Grid grid;

  GridWidget({@required this.grid});

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          children: _buildInnerGridWidgets(0),
        ),
        TableRow(
          children: _buildInnerGridWidgets(1),
        ),
        TableRow(
          children: _buildInnerGridWidgets(2),
        ),
      ],
    );
  }

  List<InnerGridWidget> _buildInnerGridWidgets(int row) {
    return this
        .grid
        .innerGrids[row]
        .map((innerGrid) => InnerGridWidget(innerGrid: innerGrid))
        .toList();
  }
}
