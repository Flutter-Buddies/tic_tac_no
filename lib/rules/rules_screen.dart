import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RulesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RulesScreenState();
}

class _RulesScreenState extends State<RulesScreen> {
  int _step = 1;

  static const List<AssetImage> images = const <AssetImage>[
    AssetImage('assets/images/Step-1.png'),
    AssetImage('assets/images/Step-2.png'),
    AssetImage('assets/images/Step-3.png'),
    AssetImage('assets/images/Step-4.png'),
    AssetImage('assets/images/Step-5.png'),
  ];

  final List<Text> rules = <Text>[
    Text("You’re faced with a tic-tac-toe board you must win.",
        style: GoogleFonts.asap(textStyle: TextStyle(fontSize: 20))),
    Text(
        "But there’s a catch... each board is part of a bigger tic-tac-toe board!",
        style: GoogleFonts.asap(textStyle: TextStyle(fontSize: 20))),
    Text(
        "You must win the inner-grid to claim the position on the main-grid. Once you claim it, no one can claim it again.",
        style: GoogleFonts.asap(textStyle: TextStyle(fontSize: 20))),
    Text(
        "Easy? There’s one more thing... your move within the inner-grid determines the inner-grid your opponent can play.",
        style: GoogleFonts.asap(textStyle: TextStyle(fontSize: 20))),
    Text("Good luck!",
        style: GoogleFonts.asap(textStyle: TextStyle(fontSize: 35))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2A5298),
      appBar: AppBar(
        title: Text('Rules',
            style: GoogleFonts.asap(
                textStyle: TextStyle(fontWeight: FontWeight.bold))),
        backgroundColor: Color(0xff1E3C72),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Center(
                  child: rules[_step - 1],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: images[_step - 1],
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
