import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

enum SupportedLocale {
  en,
  af,
  ar,
  hr,
  es,
  pl,
  he,
}

class Utils {
  static bool isCurrentLocaleRTL(BuildContext context) {
    switch (context.locale.languageCode) {
      case 'ar':
        return true;
        break;
      case 'he':
        return true;
      default:
        return false;
    }
  }

  static bool isLocaleConjugationRequired(BuildContext context) {
    switch (context.locale.languageCode) {
      case 'pl':
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
      case SupportedLocale.pl:
        locale = Locale('pl');
        break;
      case SupportedLocale.he:
        locale = Locale('he');
        break;
      default:
        locale = Locale('en');
        break;
    }

    EasyLocalization.of(context).locale = locale;
  }
}
