import 'package:flutter/material.dart';

class Themes {
  static get theme {
    final originalTextTheme = ThemeData.dark().textTheme;
    final originalBody1 = originalTextTheme.bodyText1;

    return ThemeData.dark().copyWith(
        primaryColor: Colors.black,
        accentColor: Colors.cyan[300],
        buttonColor: Colors.cyan[300],
        textSelectionColor: Colors.cyan[100],
        backgroundColor: Colors.black,
        cardColor: Colors.grey[800],
        splashColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        toggleableActiveColor: Colors.cyan[300],
        textTheme: originalTextTheme.copyWith(
            bodyText1:
            originalBody1.copyWith(decorationColor: Colors.transparent)));
  }
}