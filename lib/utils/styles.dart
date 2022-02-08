import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xff14213D);
const Color secondaryColor = Color(0xffFCA311);
const Color accentColor = Color(0xffE5E5E5);
const Color grey = Color(0xffEEEEEE);

final TextTheme myTheme = TextTheme(
  headline1: GoogleFonts.ubuntu(fontSize: 98, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headline2: GoogleFonts.ubuntu(fontSize: 61, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  headline3: GoogleFonts.ubuntu(fontSize: 49, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.ubuntu(fontSize: 35, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5: GoogleFonts.ubuntu(fontSize: 24, fontWeight: FontWeight.w400),
  headline6: GoogleFonts.ubuntu(fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  subtitle1: GoogleFonts.ubuntu(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: GoogleFonts.ubuntu(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyText2: GoogleFonts.openSans(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  button: GoogleFonts.openSans(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: GoogleFonts.openSans(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: GoogleFonts.openSans(fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);

List<BoxShadow> defaultBoxShadow({
  Color? shadowColor,
  double? blurRadius,
  double? spreadRadius,
  Offset offset = const Offset(0.0, 0.0),
}) {
  return [
    BoxShadow(
      color: shadowColor ?? Colors.grey.withOpacity(0.2),
      blurRadius: blurRadius ?? 4,
      spreadRadius: spreadRadius ?? 1.0,
      offset: offset,
    )
  ];
}
