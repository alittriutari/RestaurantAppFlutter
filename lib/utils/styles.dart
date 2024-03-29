import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xff14213D);
const Color secondaryColor = Color(0xffFCA311);
const Color accentColor = Color(0xffE5E5E5);

final TextTheme myTheme = TextTheme(
  headline1: GoogleFonts.openSans(
      fontSize: 95,
      fontWeight: FontWeight.w400,
      letterSpacing: -1.5,
      color: primaryColor),
  headline2: GoogleFonts.openSans(
      fontSize: 59,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.5,
      color: primaryColor),
  headline3: GoogleFonts.openSans(
    fontSize: 48,
    fontWeight: FontWeight.w400,
    color: primaryColor,
  ),
  headline4: GoogleFonts.openSans(
      fontSize: 34,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: primaryColor),
  headline5: GoogleFonts.openSans(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: primaryColor,
  ),
  headline6: GoogleFonts.openSans(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
      color: primaryColor),
  subtitle1: GoogleFonts.openSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
    color: primaryColor,
  ),
  subtitle2: GoogleFonts.openSans(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    color: primaryColor,
  ),
  bodyText1: GoogleFonts.openSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    color: primaryColor,
  ),
  bodyText2: GoogleFonts.openSans(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: primaryColor),
  button: GoogleFonts.openSans(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
    color: primaryColor,
  ),
  caption: GoogleFonts.openSans(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    color: primaryColor,
  ),
  overline: GoogleFonts.openSans(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
    color: primaryColor,
  ),
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
