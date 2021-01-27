
import 'dart:async';
import 'dart:convert';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show  rootBundle;

import 'LocaleUtil.dart';

/// Class for Translate
///
/// For example:
///
/// import 'package:workout/translations.dart';
///
/// ```dart
/// For TextField content
/// Translations.of(context).text("home_page_title");
/// ```
///
/// ```dart
/// For speak string
/// Note: Tts will speak english if currentLanguage[# Tts's parameter] can't support
///
/// Translations.of(context).speakText("home_page_title");
/// ```
///
/// "home_page_title" is the key for text value
///
class Translations {
  Translations(Locale locale) {
    this.locale = locale;
//    _localizedValues = null;
  }

  Locale locale;
  static Map<dynamic, dynamic> _localizedValues;
  static Map<dynamic, dynamic> _localizedValuesEn; // English map

  static Translations of(BuildContext context) {
    return Localizations.of<Translations>(context, Translations);
  }


  String text(String key) {
    try {
      String value = _localizedValues[key];
      if(value == null || value.isEmpty) {
        return englishText(key);
      } else {
        return value;
      }
    } catch (e) {
      return englishText(key);
    }
  }

  String englishText(String key) {
    return _localizedValuesEn[key] ?? '** $key not found';
  }

  static Future<Translations> load(Locale locale) async {
    String lang = SpUtil.getString("lang");
    if(TextUtil.isEmpty(lang)) {
      lang = "zh";
    }else{
      lang = lang.split('_')[0];
    }
    String currLang = SpUtil.getString("currentLanguage");
    if(!TextUtil.isEmpty(currLang)){
      lang = currLang.split('_')[0];
    }
    print('zh:$lang');
    Translations translations = new Translations(locale);
    print('rootBundle.loadString000000' + DateUtil.formatDate(DateTime.now(),format: 'yyyy-MM-dd HH:mm:ss:SSS'));
    String jsonContent = await rootBundle.loadString("local/string_${lang}.json");
    print('rootBundle.loadString1111111' + DateUtil.formatDate(DateTime.now(),format: 'yyyy-MM-dd HH:mm:ss:SSS'));
    _localizedValues = json.decode(jsonContent);
    print('rootBundle.loadString22222' + DateUtil.formatDate(DateTime.now(),format: 'yyyy-MM-dd HH:mm:ss:SSS'));
//    EventBusUtil.getInstance().fire(ObjectEvent(
//        ObjectEvent.EVENT_TAG_UPDATE_BOTTOM_WORD,
//        null));
    return translations;

  }

  get currentLanguage => locale.languageCode;
}

class TranslationsDelegate extends LocalizationsDelegate<Translations> {
  const TranslationsDelegate();

  // Support languages
  @override
  bool isSupported(Locale locale) {
    localeUtil.languageCode = locale.languageCode;
    return localeUtil.supportedLanguages.contains(locale.languageCode);
  }

  @override
  Future<Translations> load(Locale locale) => Translations.load(locale);

  @override
  bool shouldReload(TranslationsDelegate old) => true;
}

// Delegate strong init a Translations instance when language was changed
class SpecificLocalizationDelegate extends LocalizationsDelegate<Translations> {
  final Locale overriddenLocale;

  const SpecificLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => overriddenLocale != null;

  @override
  Future<Translations> load(Locale locale) => Translations.load(overriddenLocale);

  @override
  bool shouldReload(LocalizationsDelegate<Translations> old) => true;
}
