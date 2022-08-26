import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Inter",
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    unselectedWidgetColor: Colors.white,
    // inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

TextTheme textTheme() {
  return TextTheme(
    headline1: TextStyle(
        color: Colors.white, fontSize: 28, fontWeight: FontWeight.w600,fontFamily: 'Inter-Bold'),
    headline2:
        TextStyle(color: Color(0xff196819), fontSize: 12, fontWeight: FontWeight.w400,fontFamily: 'Inter'),
    headline3: TextStyle(
        color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400,fontFamily: 'Inter'),
    headline4: TextStyle(
        color: Colors.black, fontSize: 8, fontWeight: FontWeight.w300,fontFamily: 'Inter'),
    headline5: TextStyle(
        color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600,fontFamily: 'Inter'),
    headline6: TextStyle(
        color: Colors.black, fontSize: 32, fontWeight: FontWeight.w700,fontFamily: 'Inter-Bold'),
    bodyText1: TextStyle(
        color: Color(0xff196819), fontSize: 16, fontWeight: FontWeight.w500,fontFamily: 'Inter'),
    bodyText2: TextStyle(
        color: Color(0xff196819), fontSize: 16, fontWeight: FontWeight.w700,fontFamily: 'Inter-Bold'),
    // subtitle1: TextStyle(
    //     color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400,fontFamily: 'Inter'),
    // subtitle2: TextStyle(
    //     color: Colors.green, fontSize: 14, fontWeight: FontWeight.w400,fontFamily: 'Inter'),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    textTheme: TextTheme(),
  );
}

// InputDecorationTheme inputDecorationTheme() {
//   OutlineInputBorder outlineInputBorder = OutlineInputBorder(
//     borderRadius: BorderRadius.zero,
//     // borderSide: BorderSide(color: Color(0xffC0C0C0), width: 1),
//     // gapPadding: 10,
//   );
//   return InputDecorationTheme(
//     floatingLabelBehavior: FloatingLabelBehavior.always,
//     contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
//     enabledBorder: outlineInputBorder,
//     focusedBorder: outlineInputBorder,
//     // border: outlineInputBorder,
//   );
// }
