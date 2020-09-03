import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightNewsTheme = _buildLightNewsTheme();
final ThemeData darkNewsTheme = _buildDarkNewsTheme();

class _Constants {
  static const buttonColor = Color(0xFFE0E0E0);
}

ThemeData _buildLightNewsTheme() {
  final base = ThemeData.light();

  return base.copyWith(
    backgroundColor: Colors.white,
    indicatorColor: Colors.black,
    colorScheme: const ColorScheme.light(),
    buttonColor: _Constants.buttonColor,
    accentColor: Colors.black54,
    textTheme: _buildNewsTextTheme(base.textTheme, Colors.black),
  );
}

ThemeData _buildDarkNewsTheme() {
  final base = ThemeData.dark();

  return base.copyWith(
    backgroundColor: Colors.black,
    indicatorColor: Colors.white,
    colorScheme: const ColorScheme.dark(),
    buttonColor: _Constants.buttonColor,
    accentColor: Colors.grey[800],
    textTheme: _buildNewsTextTheme(base.textTheme, Colors.white),
  );
}

TextTheme _buildNewsTextTheme(TextTheme base, Color primaryTextColor) {
  return GoogleFonts.openSansTextTheme(
    base.copyWith(
      headline1: base.headline1.copyWith(
        color: primaryTextColor,
        fontWeight: FontWeight.w300,
        fontSize: 30,
      ),
      headline2: base.headline2.copyWith(
        color: primaryTextColor,
        fontWeight: FontWeight.w500,
        fontSize: 28,
      ),
      headline3: base.headline3.copyWith(
        color: primaryTextColor,
        fontWeight: FontWeight.w700,
        fontSize: 26,
      ),
      headline4: base.headline4.copyWith(
        color: primaryTextColor,
        fontWeight: FontWeight.w700,
        fontSize: 24,
      ),
      headline5: base.headline5.copyWith(
        color: primaryTextColor,
        fontWeight: FontWeight.w700,
        fontSize: 22,
      ),
      headline6: base.headline6.copyWith(
        color: primaryTextColor,
        fontWeight: FontWeight.w700,
        fontSize: 20,
      ),
      subtitle1: GoogleFonts.roboto(
        textStyle: base.subtitle1.copyWith(
          color: primaryTextColor,
          fontWeight: FontWeight.w600,
          fontSize: 19,
          height: 1.5,
          letterSpacing: 0,
          wordSpacing: 0,
        ),
      ),
      subtitle2: GoogleFonts.roboto(
        textStyle: base.subtitle2.copyWith(
          color: primaryTextColor,
          fontWeight: FontWeight.w600,
          fontSize: 17,
          height: 1.5,
          letterSpacing: 0,
          wordSpacing: 0,
        ),
      ),
      bodyText1: base.bodyText1.copyWith(
        color: primaryTextColor,
        fontWeight: FontWeight.w400,
        fontSize: 16.5,
        height: 1.5,
      ),
      bodyText2: base.bodyText2.copyWith(
        color: primaryTextColor,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      button: base.button.copyWith(
        color: primaryTextColor,
        fontWeight: FontWeight.w600,
        fontSize: 13,
      ),
      caption: base.caption.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 12,
        color: Colors.grey,
      ),
      overline: base.overline.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 12,
        color: Colors.grey,
        letterSpacing: 0,
        wordSpacing: 0,
      ),
    ),
  );
}
