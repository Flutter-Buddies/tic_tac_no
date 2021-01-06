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
    with TickerProviderStateMixin {
  Animation _animationPadding;
  AnimationController _animationControllerPadding;
  Animation _animationOpacity;
  AnimationController _animationControllerOpacity;
  @override
  void initState() {
    super.initState();
    _animationControllerPadding =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    _animationPadding = Tween<double>(begin: 70, end: 20).animate(
        CurvedAnimation(
            parent: _animationControllerPadding, curve: Curves.easeIn));
    _animationControllerOpacity = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 700),
        reverseDuration: Duration(milliseconds: 300));
    _animationOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _animationControllerOpacity, curve: Curves.easeIn));
    // _animationControllerPadding.forward();
    // _animationControllerOpacity.forward();
    _animationControllerOpacity.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        await Future.delayed(Duration(milliseconds: 1000));
        _animationControllerOpacity.reverse();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationControllerOpacity.dispose();
    _animationControllerPadding.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //! Animation runs every time the build method is called (which is a lot). How to fix?
    if (widget.innerGrid.winner != null) {
      _animationControllerPadding.forward();
      _animationControllerOpacity.forward();
    }
    return Stack(
      children: [
        AnimatedContainer(
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
        ),
        IgnorePointer(
          // IgnorePointer to stop the numbers which are currently invisible from blocking presses
          ignoring: true,
          child: AnimatedBuilder(
            animation: _animationControllerOpacity,
            builder: (context, child) {
              return AnimatedBuilder(
                  animation: _animationPadding,
                  builder: (context, child) {
                    return Center(
                      child: Opacity(
                        opacity: _animationOpacity.value,
                        child: Container(
                          padding:
                              EdgeInsets.only(top: _animationPadding.value),
                          child: Text(
                            '+1',
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
                      ),
                    );
                  });
            },
          ),
        ),
      ],
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
