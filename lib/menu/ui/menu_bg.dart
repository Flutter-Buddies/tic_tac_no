import 'package:flutter/material.dart';

class MenuBackground extends StatelessWidget {
  const MenuBackground();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xff1E3C72), Color(0xff2A5298)],
        ),
      ),
    );
  }
}
