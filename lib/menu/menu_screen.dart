import 'package:flutter/material.dart';
import 'package:tic_tac_no/menu/ui/menu_bg.dart';
import 'package:tic_tac_no/menu/ui/menu_buttons.dart';
import 'package:tic_tac_no/menu/ui/menu_settings.dart';
import 'package:tic_tac_no/menu/ui/title.dart';
import 'package:tic_tac_no/utils/utils.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const MenuBackground(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  // App Title
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: TitleWidget(),
                    ),
                  ),
                  MenuButtons(),
                ],
              ),
            ),
          ),
          Positioned(
            top: 55,
            right: Utils.isCurrentLocaleRTL(context) ? null : 32,
            left: Utils.isCurrentLocaleRTL(context) ? 32 : null,
            child: const MenuSettings(),
          ),
        ],
      ),
    );
  }
}
