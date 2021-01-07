// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

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

  /// `Location`
  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `Your location`
  String get yourLocation {
    return Intl.message(
      'Your location',
      name: 'yourLocation',
      desc: '',
      args: [],
    );
  }

  /// `Latitude`
  String get latitude {
    return Intl.message(
      'Latitude',
      name: 'latitude',
      desc: '',
      args: [],
    );
  }

  /// `Longitude`
  String get longitude {
    return Intl.message(
      'Longitude',
      name: 'longitude',
      desc: '',
      args: [],
    );
  }

  /// `Location service is not available. Please go to the settings to grant the permission.`
  String get permissionDeniedForeverErrorMessage {
    return Intl.message(
      'Location service is not available. Please go to the settings to grant the permission.',
      name: 'permissionDeniedForeverErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Permission denied. Click the button to retry action.`
  String get permissionDeniedErrorMessage {
    return Intl.message(
      'Permission denied. Click the button to retry action.',
      name: 'permissionDeniedErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Location service is not available. Please turn on the location.`
  String get locationServiceDisabledErrorMessage {
    return Intl.message(
      'Location service is not available. Please turn on the location.',
      name: 'locationServiceDisabledErrorMessage',
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

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
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

  /// `Most Shared`
  String get mostShared {
    return Intl.message(
      'Most Shared',
      name: 'mostShared',
      desc: '',
      args: [],
    );
  }

  /// `Most E-mailed`
  String get mostEmailed {
    return Intl.message(
      'Most E-mailed',
      name: 'mostEmailed',
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

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginTitle {
    return Intl.message(
      'Login',
      name: 'loginTitle',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Registration`
  String get registrationTitle {
    return Intl.message(
      'Registration',
      name: 'registrationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `E-mail`
  String get email {
    return Intl.message(
      'E-mail',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Create account`
  String get createAccount {
    return Intl.message(
      'Create account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection`
  String get noInternetException {
    return Intl.message(
      'No internet connection',
      name: 'noInternetException',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error`
  String get unknownError {
    return Intl.message(
      'Unknown error',
      name: 'unknownError',
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

  /// `This field cannot be empty`
  String get emptyFieldError {
    return Intl.message(
      'This field cannot be empty',
      name: 'emptyFieldError',
      desc: '',
      args: [],
    );
  }

  /// `Wrong e-mail format`
  String get invalidEmailError {
    return Intl.message(
      'Wrong e-mail format',
      name: 'invalidEmailError',
      desc: '',
      args: [],
    );
  }

  /// `Initialization failed. Restart the application.`
  String get initializationError {
    return Intl.message(
      'Initialization failed. Restart the application.',
      name: 'initializationError',
      desc: '',
      args: [],
    );
  }

  /// `User corresponding to the given e-mail has been disabled`
  String get userDisabledError {
    return Intl.message(
      'User corresponding to the given e-mail has been disabled',
      name: 'userDisabledError',
      desc: '',
      args: [],
    );
  }

  /// `There is no user corresponding to the given e-mail`
  String get userNotFoundError {
    return Intl.message(
      'There is no user corresponding to the given e-mail',
      name: 'userNotFoundError',
      desc: '',
      args: [],
    );
  }

  /// `Password is invalid for the given e-mail`
  String get invalidPasswordError {
    return Intl.message(
      'Password is invalid for the given e-mail',
      name: 'invalidPasswordError',
      desc: '',
      args: [],
    );
  }

  /// `E-mail address already in use`
  String get emailAlreadyInUseError {
    return Intl.message(
      'E-mail address already in use',
      name: 'emailAlreadyInUseError',
      desc: '',
      args: [],
    );
  }

  /// `The password is too weak`
  String get weakPasswordError {
    return Intl.message(
      'The password is too weak',
      name: 'weakPasswordError',
      desc: '',
      args: [],
    );
  }

  /// `E-mail/password accounts are not enabled for the project`
  String get operationNotAllowedError {
    return Intl.message(
      'E-mail/password accounts are not enabled for the project',
      name: 'operationNotAllowedError',
      desc: '',
      args: [],
    );
  }

  /// `We have blocked all requests from this device due to unusual activity. Try again later.`
  String get tooManyRequests {
    return Intl.message(
      'We have blocked all requests from this device due to unusual activity. Try again later.',
      name: 'tooManyRequests',
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