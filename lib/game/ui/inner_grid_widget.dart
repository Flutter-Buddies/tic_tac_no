import 'package:flutter/material.dart';
import 'package:tic_tac_no/common/consts/keys.dart';
import 'package:tic_tac_no/game/bloc/game_bloc.dart';
import 'package:tic_tac_no/game/data/models/inner_grid.dart';
import 'package:tic_tac_no/game/ui/square_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InnerGridWidget extends StatefulWidget {
  const InnerGridWidget({
    required this.innerGrid,
  });

  final InnerGrid innerGrid;

  @override
  _InnerGridWidgetState createState() => _InnerGridWidgetState();
}

class _InnerGridWidgetState extends State<InnerGridWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationControllerPadding;
  late Animation<double> _animationPadding;
  late AnimationController _animationControllerOpacity;
  late Animation<double> _animationOpacity;
  bool _didAnimateWinner = false;

  @override
  void initState() {
    super.initState();
    _animationControllerPadding = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _animationPadding = Tween<double>(begin: 70, end: 20).animate(
      CurvedAnimation(
        parent: _animationControllerPadding,
        curve: Curves.easeIn,
      ),
    );
    _animationControllerOpacity = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
      reverseDuration: const Duration(milliseconds: 300),
    );
    _animationOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationControllerOpacity,
        curve: Curves.easeIn,
      ),
    );
    _animationControllerOpacity.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        await Future.delayed(const Duration(milliseconds: 1000));
        await _animationControllerOpacity.reverse();
      }
    });
  }

  @override
  void dispose() {
    _animationControllerOpacity.dispose();
    _animationControllerPadding.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.innerGrid.winner != null && !_didAnimateWinner) {
      _animationControllerPadding.forward();
      _animationControllerOpacity.forward();
      // context.read<GameAudio>().playSound(SoundEvents.InnerGridWin);
      _didAnimateWinner = true;
    }
    return Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: _decideBackgroundColor(),
          ),
          curve: Curves.easeIn,
          child: Stack(
            children: [
              if (widget.innerGrid.isPlayable)
                Positioned.fill(
                  child: Container(
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),
              Table(
                border: TableBorder(
                  top: _buildBorderSide(context),
                  bottom: _buildBorderSide(context),
                  left: _buildBorderSide(context),
                  right: _buildBorderSide(context),
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
            ],
          ),
        ),
        IgnorePointer(
          // IgnorePointer to stop the numbers which are currently invisible from blocking presses
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
                          child: const Text(
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
    return this.widget.innerGrid.winner!.color.withOpacity(0.5);
  }

  // Borderside details
  final Color _isNotPlayableColor = Colors.white;

  BorderSide _buildBorderSide(BuildContext context) {
    return BorderSide(
      color: this.widget.innerGrid.isPlayable
          ? context.watch<GameBloc>().getCurrentPlayer()?.color ??
              _isNotPlayableColor
          : _isNotPlayableColor,
      width: this.widget.innerGrid.isPlayable ? 4.0 : 1.0,
    );
  }

  List<SquareWidget> _buildSquareWidgets(int row) {
    return this.widget.innerGrid.squares[row].map((square) {
      final gridPos = square.parentInnerGrid.position;
      final pos =
          'G[${gridPos.y}][${gridPos.x}]_SQ[${square.position.y}][${square.position.x}]';
      final key = Key(Keys.gameSquare + pos);
      return SquareWidget(key: key, square: square);
    }).toList();
  }
}
