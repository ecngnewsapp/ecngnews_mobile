import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'size_config.dart';

class EcngTheme {
  EcngTheme();
  static BoxDecoration cardDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(SizeConfig.sizeMultiplier)),
    color: Colors.white,
    boxShadow: [
      BoxShadow(
          color: EcngColors.shadowColor,
          blurRadius: 8,
          spreadRadius: 2,
          offset: Offset(0, 2))
    ],
  );

  static BoxDecoration imageDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(SizeConfig.sizeMultiplier)),
  );

  static ThemeData lightTheme = ThemeData(
    ///setting app colors
    primaryColor: EcngColors.primaryColor,
    backgroundColor: EcngColors.backgroundColor,
    buttonColor: EcngColors.primaryColor,
    cardColor: EcngColors.backgroundColor,
    bottomAppBarTheme: BottomAppBarTheme(
      elevation: 2,
      color: EcngColors.defaultIconColor,
    ),

    ///text Theme
    textTheme: TextTheme(
      //title
      headline3: TextStyle(
        fontFamily: GoogleFonts.nunito().fontFamily,
        fontWeight: FontWeight.bold,
      ),
      subtitle2: TextStyle(
        fontFamily: GoogleFonts.nunito().fontFamily,
        fontWeight: FontWeight.bold,
        fontSize: 43,
      ),
      subtitle1: TextStyle(
        fontFamily: GoogleFonts.nunito().fontFamily,
        fontWeight: FontWeight.bold,
        fontSize: 30,
      ),
      headline4: TextStyle(
        fontFamily: GoogleFonts.nunito().fontFamily,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      headline5: TextStyle(
        fontFamily: GoogleFonts.nunito().fontFamily,
        fontWeight: FontWeight.normal,
        fontSize: 18,
      ),
      bodyText1: TextStyle(
        fontFamily: GoogleFonts.nunito().fontFamily,
        fontWeight: FontWeight.normal,
        fontSize: 16,
      ),

      button: TextStyle(
        fontFamily: GoogleFonts.nunito().fontFamily,
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.white,
      ),
    ),
    //button Theme
    buttonTheme: ButtonThemeData(
      disabledColor: Color.fromRGBO(222, 222, 222, 100),
      buttonColor: EcngColors.primaryColor,
    ),
    //icon theme
    iconTheme: IconThemeData(
      color: EcngColors.defaultIconColor,
    ),
    cardTheme: CardTheme(),
  );
}

class EcngColors {
  static Color primaryColor = Color(0xffE20025);
  static Color chartTextColor1 = Color(0xff880000);
  static Color secondaryColor = Color(0xffF98150);
  static Color defaultIconColor = Color(0xff8497A4);
  static Color tabletChartColor = Color(0xff8497A4);
  static Color grayChartColor1 = Color(0xff898989);
  static Color cancelColor1 = Color(0xff898989);
  static Color grayColor2 = Color(0xffADADAD);
  static Color facebookColor = Color(0xff4286F5);
  static Color googleColor = Color(0xffF75A59);
  static Color desktopChartColor2 = Color(0xff93F585);
  static Color mobileChartColor2 = Color(0xff6FCF97);
  static Color blackColor = Color(0xff000000);
  static Color shadowColor = Color.fromRGBO(0, 0, 0, .16);
  static Color backgroundColor = Colors.white;
  static List<BoxShadow> cardBoxShadow = [
    BoxShadow(
      offset: Offset(0, 4),
      spreadRadius: 1,
      blurRadius: 4,
      color: EcngColors.shadowColor,
    ),
  ];
}
