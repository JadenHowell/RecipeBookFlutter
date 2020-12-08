import 'package:flutter/material.dart';
import 'package:recipebook/model/static_variables.dart';

class CustomTheme{
  static ThemeData get data => new ThemeData(
    primaryColor: StaticVariables.primaryColor,
    accentColor: StaticVariables.accentColor,
    backgroundColor: StaticVariables.backgroundColor,
    primaryColorDark: StaticVariables.darkPrimaryColor,
    primaryColorLight: StaticVariables.lightPrimaryColor,
    bottomAppBarColor: StaticVariables.primaryColor,
    cardColor: StaticVariables.tileColor,
  );

}