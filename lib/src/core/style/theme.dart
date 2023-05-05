import 'package:flutter/material.dart';

const kGreenPrimary = Color(0xff256D85);
const kGreen = Color(0xff06283D);
const kWhiteBg = Color(0xffF7F6FB);
const kwhite = Color(0xff797979);

ThemeData lightTheme = ThemeData(
  primaryColorLight: Colors.black,
  primaryColorDark: Colors.white,
  fontFamily: "Poppins",
  scaffoldBackgroundColor: kWhiteBg,
  primaryColor: kGreenPrimary,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(backgroundColor: kGreenPrimary),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontSize: 28, fontWeight: FontWeight.w800, color: Colors.black),
    displayMedium: TextStyle(
        fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
    displaySmall: TextStyle(
        fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
    titleMedium: TextStyle(fontSize: 12, color: kwhite),
  ),
);

ThemeData darkTheme = ThemeData(
  primaryColorLight: kGreen,
  primaryColorDark: kwhite,
  textTheme: const TextTheme(
    displayLarge:
        TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: kwhite),
    displayMedium:
        TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: kwhite),
    displaySmall:
        TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kwhite),
    titleMedium: TextStyle(fontSize: 12, color: kwhite),
  ),
  fontFamily: "Poppins",
  scaffoldBackgroundColor: Colors.black87,
  primaryColor: kGreen,
);
