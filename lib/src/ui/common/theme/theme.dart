import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData newsTheme = _buildNewsTheme();

ThemeData _buildNewsTheme() {
  final base = ThemeData.light();

  return base.copyWith(
    colorScheme: const ColorScheme.light(),
    textTheme: _buildNewsTextTheme(base.textTheme),
  );
}

TextTheme _buildNewsTextTheme(TextTheme base) {
  return GoogleFonts.openSansTextTheme(
    base.copyWith(
      headline1: base.headline1.copyWith(
        color: Colors.black,
        fontWeight: FontWeight.w300,
        fontSize: 30,
      ),
      headline2: base.headline2.copyWith(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 28,
      ),
      headline3: base.headline3.copyWith(
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontSize: 26,
      ),
      headline4: base.headline4.copyWith(
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontSize: 24,
      ),
      headline5: base.headline5.copyWith(
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontSize: 22,
      ),
      headline6: base.headline6.copyWith(
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontSize: 20,
      ),
      subtitle1: GoogleFonts.roboto(
        textStyle: base.subtitle1.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 19,
          height: 1.5,
          letterSpacing: 0,
          wordSpacing: 0,
        ),
      ),
      subtitle2: GoogleFonts.roboto(
        textStyle: base.subtitle2.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 17,
          height: 1.5,
          letterSpacing: 0,
          wordSpacing: 0,
        ),
      ),
      bodyText1: base.bodyText1.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 16.5,
        height: 1.5,
      ),
      bodyText2: base.bodyText2.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      button: base.button.copyWith(
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
