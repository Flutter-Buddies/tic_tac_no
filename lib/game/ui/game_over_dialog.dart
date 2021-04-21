import 'package:flutter/material.dart';
import 'package:tic_tac_no/common/consts/keys.dart';
import 'package:tic_tac_no/game/bloc/game_bloc.dart';
import 'package:tic_tac_no/game/data/models/player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_no/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tic_tac_no/utils/audio.dart';
import 'package:tic_tac_no/utils/utils.dart';

class GameOverDialog extends StatelessWidget {
  const GameOverDialog({
    this.winner,
  });

  final Player? winner;

  String _getWinnerString(BuildContext context) {
    final winner = this.winner!;
    if (Utils.isLocaleConjugationRequired(context) &&
        winner.type == PlayerType.me) {
      return '${winner.name} ${LocaleKeys.game_win.tr()}'.toUpperCase();
    }
    return '${winner.name} ${LocaleKeys.game_won.tr()}'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(24.0),
      titlePadding: const EdgeInsets.only(top: 24.0),
      backgroundColor: const Color(0xff012E44),
      title: Center(
        child: winner != null
            ? Text(_getWinnerString(context))
            : Text(LocaleKeys.game_nobody_wins.tr().toUpperCase()),
      ),
      children: [
        FractionallySizedBox(
          widthFactor: 0.3,
          child: AspectRatio(
            aspectRatio: 1.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: winner?.symbol != null
                  ? CustomPaint(painter: winner!.symbol)
                  : Container(),
            ),
          ),
        ),
        const SizedBox(
          height: 24.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  context.read<UIAudio>().playSound(UISounds.ButtonClick);
                  context.read<GameBloc>().add(Reset());
                  Navigator.of(context)
                      .popUntil((route) => route.settings.name == '/');
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: const Color(0xffFF5F6D),
                  ),
                  child: Center(
                    child: Text(
                      LocaleKeys.game_quit_to_menu.tr(),
                      key: const Key(Keys.gameQuitToMenuText),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 16.0,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // Reset the board then close the modal

                  context.read<UIAudio>().playSound(UISounds.ButtonClick);
                  context.read<GameBloc>().add(Reset());

                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xff009E95),
                  ),
                  child: Center(
                    child: Text(
                      LocaleKeys.game_play_again.tr(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
