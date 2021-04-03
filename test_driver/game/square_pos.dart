class SquarePos {
  const SquarePos(
    this.gX,
    this.gY,
    this.sqX,
    this.sqY, {
    this.playerId = 1,
  });

  final int gX;
  final int gY;

  final int sqX;
  final int sqY;

  final int playerId;

  @override
  String toString() =>
      'SquarePos{gX: $gX, gY: $gY, sqX: $sqX, sqY: $sqY, playerId: $playerId}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SquarePos &&
          runtimeType == other.runtimeType &&
          gX == other.gX &&
          gY == other.gY &&
          sqX == other.sqX &&
          sqY == other.sqY &&
          playerId == other.playerId;

  @override
  int get hashCode =>
      gX.hashCode ^
      gY.hashCode ^
      sqX.hashCode ^
      sqY.hashCode ^
      playerId.hashCode;
}
