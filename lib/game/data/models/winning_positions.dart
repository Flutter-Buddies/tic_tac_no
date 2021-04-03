// ignore: constant_identifier_names
enum LineType { Veritical, Horizontal, DiagonalBack, DiagonalForward }

class WinningPositions {
  const WinningPositions({this.lineType, this.thirdPosition});

  final LineType lineType;
  final int thirdPosition;

  @override
  String toString() =>
      'WinningPositions(lineType: $lineType, thirdPosition: $thirdPosition)';
}
