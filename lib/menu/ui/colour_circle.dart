import 'package:flutter/material.dart';

class ColourCircle extends StatelessWidget {
  ColourCircle({this.circleColor, this.isSelected, this.selectorFunction});
  final Color circleColor;
  final bool isSelected;
  final Function selectorFunction;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () => selectorFunction(),
        child: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: circleColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? Colors.white : Colors.transparent,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
