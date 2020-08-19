// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

class Strings {
  Strings();
  
  static Strings current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<Strings> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      Strings.current = Strings();
      
      return Strings.current;
    });
  } 

  static Strings of(BuildContext context) {
    return Localizations.of<Strings>(context, Strings);
  }

  /// `About`
  String get aboutApp {
    return Intl.message(
      'About',
      name: 'aboutApp',
      desc: '',
      args: [],
    );
  }

  /// `Application fully written in Flutter`
  String get appInfoTechnicalDescription {
    return Intl.message(
      'Application fully written in Flutter',
      name: 'appInfoTechnicalDescription',
      desc: '',
      args: [],
    );
  }

  /// `The latest news from the world`
  String get appInfoFeatureDescription {
    return Intl.message(
      'The latest news from the world',
      name: 'appInfoFeatureDescription',
      desc: '',
      args: [],
    );
  }

  /// `E-mailed`
  String get emailed {
    return Intl.message(
      'E-mailed',
      name: 'emailed',
      desc: '',
      args: [],
    );
  }

  /// `Dark mode`
  String get darkMode {
    return Intl.message(
      'Dark mode',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `Newest`
  String get newest {
    return Intl.message(
      'Newest',
      name: 'newest',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Most Viewed`
  String get mostViewed {
    return Intl.message(
      'Most Viewed',
      name: 'mostViewed',
      desc: '',
      args: [],
    );
  }

  /// `Popular`
  String get popular {
    return Intl.message(
      'Popular',
      name: 'popular',
      desc: '',
      args: [],
    );
  }

  /// `Shared`
  String get shared {
    return Intl.message(
      'Shared',
      name: 'shared',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Show All`
  String get showAll {
    return Intl.message(
      'Show All',
      name: 'showAll',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get version {
    return Intl.message(
      'Version',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `Viewed`
  String get viewed {
    return Intl.message(
      'Viewed',
      name: 'viewed',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection`
  String get apiConnectionException {
    return Intl.message(
      'No internet connection',
      name: 'apiConnectionException',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error`
  String get apiUnknownException {
    return Intl.message(
      'Unknown error',
      name: 'apiUnknownException',
      desc: '',
      args: [],
    );
  }

  /// `Authorization error`
  String get apiUnauthorizedException {
    return Intl.message(
      'Authorization error',
      name: 'apiUnauthorizedException',
      desc: '',
      args: [],
    );
  }

  /// `Internal server error`
  String get apiServerException {
    return Intl.message(
      'Internal server error',
      name: 'apiServerException',
      desc: '',
      args: [],
    );
  }

  /// `Resource not found`
  String get apiInvalidUrlException {
    return Intl.message(
      'Resource not found',
      name: 'apiInvalidUrlException',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<Strings> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'pl'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<Strings> load(Locale locale) => Strings.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}