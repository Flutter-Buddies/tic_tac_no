import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              onPressed: () => Navigator.of(context).pushNamed('/settings'),
              child: Text('Settings'),
            ),
            RaisedButton(
              onPressed: () => Navigator.of(context).pushNamed('/game'),
              child: Text('Game'),
            )
          ],
        ),
      ),
    );
  }
}
