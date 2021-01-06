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

class _InnerGridWidgetState extends State<InnerGridWidget>
    with SingleTickerProviderStateMixin {
  Animation _animation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );
    _animation = Tween(begin: 1.0, end: 10.0).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeInOutQuad));
    // _animationController.addListener(() {
    //   setState(() {});
    // });
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reset();
      }
    });
    // _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (this.widget.innerGrid.winner != null) {
      print('There was a winner!');
      _animationController.forward();
    }
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
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
      },
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
  double _borderOpacity = 1.0;

  BorderSide _buildBorderSide() {
    return BorderSide(
      color: this.widget.innerGrid.isPlayable
          ? _isPlayableColor.withOpacity(_borderOpacity / _animation.value)
          : _isNotPlayableColor.withOpacity(_borderOpacity),
      width: this.widget.innerGrid.isPlayable ? 3.0 : _animation.value,
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
