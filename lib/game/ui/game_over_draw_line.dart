import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_no/game/bloc/game_bloc.dart';
import 'package:tic_tac_no/game/data/models/winning_positions.dart';

class GameOverDrawLine extends StatefulWidget {
  @override
  _GameOverDrawLineState createState() => _GameOverDrawLineState();
}

class _GameOverDrawLineState extends State<GameOverDrawLine>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(curve: Curves.easeIn, parent: animationController));

    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameBloc, GameState>(
      listener: (context, state) {
        if (state is GameOver) {
          animationController.forward();
        }
        if (state is Ready) {
          animationController.reset();
        }
      },
      child: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          if (state is GameOver && state.winningPositions != null) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return Center(
                  // Line goes all the way to the edge for the calculations to work so
                  // ClipRect added so the lines don't look like they go to the edge
                  child: ClipRect(
                    child: Align(
                      widthFactor: 0.9,
                      heightFactor: 0.9,
                      child: SizedBox(
                        width: constraints.maxWidth,
                        height: constraints.maxHeight,
                        child: CustomPaint(
                          painter: WinningLine(
                            animation.value,
                            state.winningPositions!,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class WinningLine extends CustomPainter {
  WinningLine(
    this.animationValue,
    this.winningPositions,
  );

  final double animationValue;
  final WinningPositions winningPositions;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = size.width * 0.02;

    // Initialise starting points
    Offset startingPoint;
    Offset endingPoint;

    // Helper function to move the line depending on what row or column won
    Offset translation({
      required int thirdPosition,
      required Offset offset,
      required LineType lineType,
    }) {
      if (thirdPosition == 1 && lineType == LineType.Veritical) {
        return offset.translate(size.width / 6, 0);
      }
      if (thirdPosition == 2 && lineType == LineType.Veritical) {
        return offset.translate(size.width * 3 / 6, 0);
      }
      if (thirdPosition == 3 && lineType == LineType.Veritical) {
        return offset.translate(size.width * 5 / 6, 0);
      }
      if (thirdPosition == 1 && lineType == LineType.Horizontal) {
        return offset.translate(0, size.height / 6);
      }
      if (thirdPosition == 2 && lineType == LineType.Horizontal) {
        return offset.translate(0, size.height * 3 / 6);
      }
      if (thirdPosition == 3 && lineType == LineType.Horizontal) {
        return offset.translate(0, size.height * 5 / 6);
      }
      return offset;
    }

    switch (winningPositions.lineType) {
      case LineType.Veritical:
        startingPoint = translation(
            lineType: LineType.Veritical,
            offset: const Offset(0, 0),
            thirdPosition: winningPositions.thirdPosition);
        endingPoint = translation(
            lineType: LineType.Veritical,
            offset: Offset(0, size.height * animationValue),
            thirdPosition: winningPositions.thirdPosition);
        break;
      case LineType.Horizontal:
        startingPoint = translation(
            lineType: LineType.Horizontal,
            offset: const Offset(0, 0),
            thirdPosition: winningPositions.thirdPosition);
        endingPoint = translation(
            lineType: LineType.Horizontal,
            offset: Offset(size.width * animationValue, 0),
            thirdPosition: winningPositions.thirdPosition);
        break;
      case LineType.DiagonalForward:
        startingPoint = Offset(0, size.height);
        endingPoint = Offset(
            size.width * animationValue, (1 - animationValue) * size.height);
        break;
      case LineType.DiagonalBack:
        startingPoint = const Offset(0, 0);
        endingPoint =
            Offset(size.width * animationValue, size.height * animationValue);
        break;
    }

    // Draw the line
    canvas.drawLine(startingPoint, endingPoint, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
