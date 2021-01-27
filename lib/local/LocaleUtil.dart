import 'package:flutter/material.dart';

typedef void LocaleChangeCallback(Locale locale);
class LocaleUtil {

  // Support languages list
  final List<String> supportedLanguages = ['en','zh'];

  // Support Locales list
  Iterable<Locale> supportedLocales() => supportedLanguages.map<Locale>((lang) => new Locale(lang, ''));
//  Iterable<Locale> supportedLocales(){
//    return [Locale('en', ''),Locale('zh', '')];
////    return supportedLanguages.map<Locale>((lang) => new Locale(lang, '')).toList();
//  }

  // Callback for manual locale changed
  LocaleChangeCallback onLocaleChanged;

  Locale locale;
  String languageCode;

  static final LocaleUtil _localeUtil = new LocaleUtil._internal();

  factory LocaleUtil() {
    return _localeUtil;
  }

  LocaleUtil._internal();

  /// 获取当前系统语言
  String getLanguageCode() {
    if(languageCode == null) {
      return "en";
    }
    return languageCode;
  }
}

LocaleUtil localeUtil = new LocaleUtil();
