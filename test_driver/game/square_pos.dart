class SquarePos {
  final int gX;
  final int gY;

  final int sqX;
  final int sqY;

  final int playerId;

  const SquarePos(
    this.gX,
    this.gY,
    this.sqX,
    this.sqY, {
    this.playerId = 1,
  });
}
