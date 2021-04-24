import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_no/common/consts/keys.dart';
import 'package:tic_tac_no/common/widgets/animate_icons.dart';
import 'package:tic_tac_no/menu/ui/language_bottom_sheet.dart';
import 'package:tic_tac_no/translations/locale_keys.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_no/utils/audio.dart';
import 'package:easy_localization/easy_localization.dart';

class MenuSettings extends StatefulWidget {
  const MenuSettings();
  @override
  _MenuSettingsState createState() => _MenuSettingsState();
}

class _MenuSettingsState extends State<MenuSettings> {
  final _controller = AnimateIconController();

  static void languageButtonPress(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return LanguageBottomSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          key: const Key(Keys.menuSoundBtn),
          child: AnimateIcons(
            startIcon: Icons.volume_up,
            endIcon: Icons.volume_off,
            controller: _controller,
            onStartIconPress: () {
              setState(() {
                context.read<UIAudio>().switchMute();
              });
              return true;
            },
            onEndIconPress: () {
              setState(() {
                context.read<UIAudio>().switchMute();
              });
              return true;
            },
            duration: const Duration(milliseconds: 500),
            startIconColor: Colors.white,
            endIconColor: Colors.redAccent,
          ),
        ),
        const SizedBox(height: 15),
        GestureDetector(
          key: const Key(Keys.menuRulesBtn),
          onTap: () => Navigator.of(context).pushNamed('/rules'),
          child: Row(
            children: [
              const Icon(
                Icons.info_outline,
                color: Colors.white,
                size: 14,
              ),
              const SizedBox(
                width: 2,
              ),
              Text(
                LocaleKeys.menu_how_to_play.tr(),
                key: const Key(Keys.menuHowToPlayText),
                style: GoogleFonts.cairo(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    // decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        GestureDetector(
          key: const Key(Keys.menuLanguageBtn),
          onTap: () => languageButtonPress(context),
          child: Row(
            children: [
              const Icon(
                Icons.language,
                color: Colors.white,
                size: 14,
              ),
              const SizedBox(
                width: 2,
              ),
              Text(
                LocaleKeys.menu_change_language.tr(),
                style: GoogleFonts.cairo(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    // decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        GestureDetector(
          onTap: () => Navigator.of(context).pushNamed('/contributors'),
          child: Row(
            children: [
              const Icon(
                Icons.code,
                color: Colors.white,
                size: 14,
              ),
              const SizedBox(
                width: 2,
              ),
              Text(
                LocaleKeys.contributors_contributors.tr(),
                style: GoogleFonts.cairo(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
