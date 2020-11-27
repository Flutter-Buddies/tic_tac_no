import 'package:flutter/material.dart';
import 'package:tic_tac_no/menu/menu_enums.dart';
import 'package:tic_tac_no/menu/ui/primary_button.dart';
import 'package:tic_tac_no/menu/ui/title.dart';
import 'package:tic_tac_no/menu/ui/game_start_bottom_sheet.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void primaryButtonPress(GameType gameType) {
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return GameStartModal(
            gameType: gameType,
          );
        },
      );
    }

    return Theme(
      data: ThemeData(
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 100,
            color: Colors.white,
            letterSpacing: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff1E3C72), Color(0xff2A5298)],
          )),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App Title
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: TitleWidget(),
                    ),
                  ),
                  // List of buttons
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PrimaryButton(
                        buttonText: 'SINGLE PLAYER',
                        buttonIcon: Icons.person,
                        buttonPress: () =>
                            primaryButtonPress(GameType.SinglePlayer),
                        //Navigator.of(context).pushNamed('/game'),
                        buttonGradient: LinearGradient(
                            colors: [Color(0xffFF5F6D), Color(0xffFFC371)]),
                      ),
                      PrimaryButton(
                        buttonText: 'LOCAL MULTIPLAYER',
                        buttonIcon: Icons.phone_android_outlined,
                        buttonPress: () =>
                            primaryButtonPress(GameType.LocalMultiplayer),
                        buttonGradient: LinearGradient(
                            colors: [Color(0xffE33E49), Color(0xff9B00B5)]),
                      ),
                      PrimaryButton(
                        buttonText: 'ONLINE MULTIPLAYER',
                        buttonIcon: Icons.people,
                        buttonPress: () =>
                            primaryButtonPress(GameType.OnlineMultiplayer),
                        buttonGradient: LinearGradient(
                            colors: [Color(0xff9534E1), Color(0xff009E95)]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
