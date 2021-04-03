import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_no/common/consts/keys.dart';
import 'package:tic_tac_no/translations/locale_keys.g.dart';

class RulesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RulesScreenState();
}

class _RulesScreenState extends State<RulesScreen> {
  int _step = 1;

  static const List<AssetImage> images = <AssetImage>[
    AssetImage('assets/images/Step-1.png'),
    AssetImage('assets/images/Step-2.png'),
    AssetImage('assets/images/Step-3.png'),
    AssetImage('assets/images/Step-4.png'),
    AssetImage('assets/images/Step-5.png'),
  ];

  final List<Text> rules = <Text>[
    Text(LocaleKeys.rules_tic_must_win.tr(),
        style: GoogleFonts.cairo(textStyle: const TextStyle(fontSize: 20))),
    Text(LocaleKeys.rules_there_is_catch.tr(),
        style: GoogleFonts.cairo(textStyle: const TextStyle(fontSize: 20))),
    Text(LocaleKeys.rules_win_inner_grid.tr(),
        style: GoogleFonts.cairo(textStyle: const TextStyle(fontSize: 20))),
    Text(LocaleKeys.rules_one_more_thing.tr(),
        style: GoogleFonts.cairo(textStyle: const TextStyle(fontSize: 20))),
    Text(LocaleKeys.rules_good_luck.tr(),
        style: GoogleFonts.cairo(textStyle: const TextStyle(fontSize: 35))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2A5298),
      appBar: AppBar(
        title: Text(LocaleKeys.rules_rules.tr(),
            style: GoogleFonts.cairo(
                textStyle: const TextStyle(fontWeight: FontWeight.bold))),
        backgroundColor: const Color(0xff1E3C72),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Center(
                child: rules[_step - 1],
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
                    key: const Key(Keys.rulesPreviousBtn),
                    onPressed: () => setState(() => _step--),
                    child: Text(LocaleKeys.rules_previous.tr()),
                  ),
                if (_step < 5)
                  ElevatedButton(
                    key: const Key(Keys.rulesNextBtn),
                    onPressed: () => setState(() => _step++),
                    child: Text(LocaleKeys.rules_next.tr()),
                  ),
                if (_step == 5)
                  ElevatedButton(
                    key: const Key(Keys.rulesStartBtn),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(LocaleKeys.rules_start.tr()),
                  ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
