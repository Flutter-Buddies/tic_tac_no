import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_no/utils/utils.dart';
import 'package:tic_tac_no/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageBottomSheet extends StatefulWidget {
  @override
  _LanguageBottomSheetState createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.6,
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xff012E44),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.menu_change_language.tr(),
                    style: GoogleFonts.cairo(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  children: [
                    /// emojis from: https://emojipedia.org/flags/
                    LanguageListTile(
                      languageEmoji: '🇬🇧',
                      languageName: 'English',
                      showCheck: Utils.currentLocale(context) == Locale('en'),
                      locale: SupportedLocale.en,
                    ),
                    LanguageListTile(
                      languageEmoji: '🇸🇦',
                      languageName: 'العربية',
                      showCheck: Utils.currentLocale(context) == Locale('ar'),
                      locale: SupportedLocale.ar,
                    ),
                    LanguageListTile(
                      languageEmoji: '🇭🇷',
                      languageName: 'Hrvatski',
                      showCheck: Utils.currentLocale(context) == Locale('hr'),
                      locale: SupportedLocale.hr,
                    ),
                    LanguageListTile(
                      languageEmoji: '🇪🇸',
                      languageName: 'Español',
                      showCheck: Utils.currentLocale(context) == Locale('es'),
                      locale: SupportedLocale.es,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LanguageListTile extends StatelessWidget {
  final String languageEmoji;
  final String languageName;
  final bool showCheck;
  final SupportedLocale locale;

  const LanguageListTile({
    Key key,
    @required this.languageEmoji,
    @required this.languageName,
    @required this.showCheck,
    @required this.locale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        languageEmoji,
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      title: Text(
        languageName,
        style: GoogleFonts.cairo(
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      trailing: showCheck
          ? Icon(
              Icons.check,
            )
          : null,
      onTap: () {
        Utils.changeLocale(context, locale);
        Navigator.pop(context);
      },
    );
  }
}
