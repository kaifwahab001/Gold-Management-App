import 'package:flutter/material.dart';
import 'package:gold_app/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextstyle {
  static TextStyle appbarStyle = GoogleFonts.roboto(
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.normal,
  );

  static TextStyle mainTextStyle = GoogleFonts.roboto(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  static TextStyle splashscreenStyle = GoogleFonts.roboto(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  static TextStyle languageScreenNameStyle = GoogleFonts.roboto(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: Appcolor.mainColor,
  );
  static TextStyle languageScreenStyle = GoogleFonts.roboto(
    fontSize: 40,
    fontWeight: FontWeight.bold,
  );

  static TextStyle languageScreenSubStyle = GoogleFonts.roboto(
    fontSize: 15,
    fontWeight: FontWeight.w300,
  );

  static TextStyle mainHeadingStyle = GoogleFonts.roboto(
    fontSize: 17,
    fontWeight: FontWeight.w500,
  );

  static TextStyle subHeadingStyle = GoogleFonts.roboto(
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  static TextStyle subTextStyle = GoogleFonts.roboto(
    fontSize: 14,
    color: Colors.grey.shade600,
  );

  static TextStyle secondSubTextStyle = GoogleFonts.roboto(
    fontSize: 15,
    color: Appcolor.mainColor,
  );

  static TextStyle labelStyle = GoogleFonts.roboto(
    fontSize: 15,
    color: Colors.grey,
    fontWeight: FontWeight.w600,
  );

  static TextStyle hintStyle = GoogleFonts.roboto(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: Colors.grey.shade600,
  );

  static TextStyle btnStyle = GoogleFonts.roboto(
    fontSize: 15,
    fontWeight: FontWeight.normal,
  );

  static TextStyle goldInventoryStyleInactive = GoogleFonts.roboto(
    color: Colors.green,
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );
  static TextStyle goldInventoryStyleActive = GoogleFonts.roboto(
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.normal,
  );
}
