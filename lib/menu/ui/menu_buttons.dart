import 'package:flutter/material.dart';
import 'package:tic_tac_no/common/consts/keys.dart';
import 'package:tic_tac_no/menu/menu_enums.dart';
import 'package:tic_tac_no/menu/ui/game_start_bottom_sheet.dart';
import 'package:tic_tac_no/menu/ui/primary_button.dart';
import 'package:tic_tac_no/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_no/utils/audio.dart';

import 'button_banner.dart';

class MenuButtons extends StatelessWidget {
  const MenuButtons();

  void primaryButtonPress(GameType gameType, BuildContext context) {
    context.read<UIAudio>().playSound(UISounds.ButtonClick);
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return GameStartModal(
          key: const Key(Keys.gameSetupModalSheet),
          gameType: gameType,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: PrimaryButton(
            key: const Key(Keys.menuGameSpBtn),
            buttonText: LocaleKeys.menu_single_player.tr(),
            buttonIcon: Icons.person,
            buttonPress: () =>
                primaryButtonPress(GameType.SinglePlayer, context),
            buttonGradient: const LinearGradient(
              colors: [Color(0xffFF5F6D), Color(0xffFFC371)],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: PrimaryButton(
            key: const Key(Keys.menuGameLocalMpBtn),
            buttonText: LocaleKeys.menu_local_multiplayer.tr(),
            buttonIcon: Icons.phone_android_outlined,
            buttonPress: () =>
                primaryButtonPress(GameType.LocalMultiplayer, context),
            buttonGradient: const LinearGradient(
              colors: [Color(0xffE33E49), Color(0xff9B00B5)],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              PrimaryButton(
                key: const Key(Keys.menuGameOnlineMpBtn),
                buttonText: LocaleKeys.menu_online_multiplayer.tr(),
                buttonIcon: Icons.people,
                buttonPress: () {
                  // Do nothing
                },
                buttonGradient: const LinearGradient(
                  colors: [Color(0xff9534E1), Color(0xff009E95)],
                ),
              ),
              ButtonBanner(LocaleKeys.menu_coming_soon.tr()),
            ],
          ),
        ),
      ],
    );
  }
}
