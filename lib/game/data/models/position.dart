import 'package:equatable/equatable.dart';

class Position extends Equatable {
  const Position(this.x, this.y);

  final int x;
  final int y;

  @override
  List<Object> get props => [x, y];
}
