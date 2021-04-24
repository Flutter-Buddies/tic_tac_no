// ignore: constant_identifier_names
enum LineType { Veritical, Horizontal, DiagonalBack, DiagonalForward }

class WinningPositions {
  const WinningPositions({
    required this.lineType,
    required this.thirdPosition,
  });

  final LineType lineType;
  final int thirdPosition;

  @override
  String toString() =>
      'WinningPositions(lineType: $lineType, thirdPosition: $thirdPosition)';
}
