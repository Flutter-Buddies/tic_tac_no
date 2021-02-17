import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

enum SupportedLocale {
  en,
  af,
  ar,
  hr,
  es,
}

class Utils {
  static bool isCurrentLocaleRTL(BuildContext context) {
    switch (context.locale.languageCode) {
      case 'ar':
        return true;
        break;
      default:
        return false;
    }
  }

  static Locale currentLocale(BuildContext context) {
    return context.locale;
  }

  static void changeLocale(
      BuildContext context, SupportedLocale supportedLocale) {
    Locale locale;

    switch (supportedLocale) {
      case SupportedLocale.en:
        locale = Locale('en');
        break;
      case SupportedLocale.af:
        locale = Locale('af');
        break;
      case SupportedLocale.ar:
        locale = Locale('ar');
        break;
      case SupportedLocale.hr:
        locale = Locale('hr');
        break;
      case SupportedLocale.es:
        locale = Locale('es');
        break;
      default:
        locale = Locale('en');
        break;
    }

    EasyLocalization.of(context).locale = locale;
  }
}
