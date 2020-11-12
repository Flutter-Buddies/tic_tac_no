import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Player extends Equatable {
  final String name;
  final Color color;

  Player({
    this.name: 'No name',
    this.color: const Color(0xFFFF0000),
  });

  @override
  List<Object> get props => [name, color];
}
