import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

enum SupportedLocale {
  en,
  af,
  ar,
  hr,
  es,
  pl,
  he,
  zh,
  cs,
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
      case 'cs':
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
      case SupportedLocale.zh:
        locale = Locale('zh');
        break;
      case SupportedLocale.cs:
        locale = Locale('cs');
        break;
      default:
        locale = Locale('en');
        break;
    }

    EasyLocalization.of(context).setLocale(locale);
  }

  static Future<void> launchUrl(String url) async {
    await url_launcher.launch(
      url,
      forceSafariVC: true,
      forceWebView: true,
      enableJavaScript: true,
      webOnlyWindowName: "hello",
    );
  }
}
