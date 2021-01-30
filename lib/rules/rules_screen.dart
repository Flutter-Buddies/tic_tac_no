import 'package:flutter/material.dart';

class RulesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RulesScreenState();
}

class _RulesScreenState extends State<RulesScreen> {
  int _step = 1;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Rules'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 32),
            if (_step == 1)
              Text("You’re faced with a tic-tac-toe board you must win."),
            if (_step == 2)
              Text("But there’s a catch; each square is a tic-tac-toe board!"),
            if (_step == 3)
              Text(
                  "You must win the inner grid to claim this position on main grid. Once you claim it, no one can claim it again."),
            if (_step == 4)
              Text(
                  "Easy? There’s one more thing; your move within InnerGird determines in which InnerGrid can your opponent play"),
            if (_step == 5) Text("good luck"),
            Spacer(),
            Container(
              width: size.width / 2,
              height: size.height / 2,
              color: Colors.white,
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_step > 1)
                  ElevatedButton(
                    onPressed: () => setState(() => _step--),
                    child: Text('Previous'),
                  ),
                if (_step < 5)
                  ElevatedButton(
                    onPressed: () => setState(() => _step++),
                    child: Text('Next'),
                  ),
                if (_step == 5)
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Start'),
                  ),
              ],
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
