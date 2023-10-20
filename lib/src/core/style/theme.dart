import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

const kGreenPrimary = Color(0xff256D85);
const kGreen = Color(0xff06283D);
const kBlueColor = Color(0xff00296b);
const kWhiteBg = Color(0xffF7F6FB);
const kwhite = Color(0xff797979);

ThemeData lightTheme = FlexThemeData.light(
    colors: const FlexSchemeColor(
      primary: Color(0xff00296b),
      primaryContainer: Color(0xffa0c2ed),
      secondary: Color(0xffd26900),
      secondaryContainer: Color(0xffffd270),
      tertiary: Color(0xff5c5c95),
      tertiaryContainer: Color(0xffc8dbf8),
      appBarColor: Color(0xffc8dcf8),
      error: null,
    ),
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 7,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 10,
      blendOnColors: false,
      useTextTheme: true,
      useM2StyleDividerInM3: true,
      inputDecoratorRadius: 19.0,
      alignedDropdown: true,
      useInputDecoratorThemeInDialogs: true,
      inputDecoratorFillColor: Color.fromARGB(255, 255, 255, 255),
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    fontFamily: 'Poppins');

ThemeData darkTheme = FlexThemeData.dark(
  scheme: FlexScheme.blue,
  surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
  blendLevel: 13,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 20,
    useTextTheme: true,
    useM2StyleDividerInM3: true,
    inputDecoratorRadius: 19.0,
    alignedDropdown: true,
    useInputDecoratorThemeInDialogs: true,
    filledButtonRadius: 14,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  swapLegacyOnMaterial3: true,
);
