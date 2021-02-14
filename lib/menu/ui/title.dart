import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_no/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tic_tac_no/utils/utils.dart';

class TitleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.menu_tic.tr(),
          style: Utils.currentLocale(context) == Locale('ar')
              ? GoogleFonts.cairo(
                  textStyle: Theme.of(context).textTheme.headline1,
                )
              : GoogleFonts.firaCode(
                  textStyle: Theme.of(context).textTheme.headline1,
                ),
        ),
        Text(
          LocaleKeys.menu_tac.tr(),
          style: Utils.currentLocale(context) == Locale('ar')
              ? GoogleFonts.cairo(
                  textStyle: Theme.of(context).textTheme.headline1,
                )
              : GoogleFonts.firaCode(
                  textStyle: Theme.of(context).textTheme.headline1,
                ),
        ),
        Text(
          LocaleKeys.menu_no.tr(),
          style: Utils.currentLocale(context) == Locale('ar')
              ? GoogleFonts.cairo(
                  textStyle: Theme.of(context).textTheme.headline1,
                )
              : GoogleFonts.firaCode(
                  textStyle: Theme.of(context).textTheme.headline1,
                ),
        ),
      ],
    );
  }
}
