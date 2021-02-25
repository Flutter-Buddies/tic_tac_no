enum LineType { Veritical, Horizontal, DiagonalBack, DiagonalForward }

class WinningPositions {
  final LineType lineType;
  final int thirdPosition;

  const WinningPositions({this.lineType, this.thirdPosition});

  @override
  String toString() =>
      'WinningPositions(lineType: $lineType, thirdPosition: $thirdPosition)';
}
