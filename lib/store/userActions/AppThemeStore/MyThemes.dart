import 'dart:ui';

import 'package:flutter/material.dart';

class MyThemeProp {
  String name;
  Color color;

  @override
  bool operator ==(other) {
    if (other is! MyThemeProp) {
      return false;
    }
    return name == (other as MyThemeProp).name;
  }

  MyThemeProp({this.name, this.color}) : super();
}

class MyTheme {
  String name;
  MyThemeProp primary;
  MyThemeProp secondary;
  MyThemeProp general;
  MyThemeProp generalSecondary;
  MyThemeProp generalInverted;
  MyThemeProp separators;
  MyThemeProp background;

  MyThemeProp getThemePropByName(String name) {
    if (name == 'primary') {
      return primary;
    } else if (name == 'secondary') {
      return secondary;
    } else if (name == 'general') {
      return general;
    } else if (name == 'generalSecondary') {
      return generalSecondary;
    } else if (name == 'generalInverted') {
      return generalInverted;
    } else if (name == 'separators') {
      return separators;
    } else if (name == 'background') {
      return background;
    }

    return primary;
  }

  MyTheme({
    @required this.name,
    @required this.primary,
    @required this.secondary,
    @required this.general,
    @required this.generalSecondary,
    @required this.generalInverted,
    @required this.separators,
    @required this.background
  }) : super();

  MyTheme.fromBaseColors({
    @required String name,
    @required MyThemeProp primary,
    @required MyThemeProp secondary
  }) : super() {
    this.name = name;
    this.primary = primary;
    this.secondary = secondary;
    this.general = MyThemeProp(name: 'General', color: Color(0xFF111111));
    this.generalSecondary = MyThemeProp(name: 'General Secondary', color: Color(0xFFbdbdbf));
    this.generalInverted = MyThemeProp(name: 'General Inverted', color: Color(0xFFf9f9f9));
    this.separators = MyThemeProp(name: 'Separators', color: Color(0xFFC2C2C6));
    this.background = MyThemeProp(name: 'Background', color: Color(0xFFffffff));
  }
}

class MyThemes {
  static Map<String, MyTheme> allThemes = {
    'Blue': MyTheme.fromBaseColors(
      name: 'Blue',
      primary: MyThemeProp(name: 'primary', color: Color(0xFF007aff)),
      secondary: MyThemeProp(name: 'secondary', color: Color(0xFFd2e7ff)),
    ),

    'Monochrome': MyTheme.fromBaseColors(
        name: 'Monochrome',
        primary: MyThemeProp(name: 'primary', color: Color(0xFF5f5f5f)),
        secondary: MyThemeProp(name: 'secondary', color: Color(0xFFececec)),
    ),

    'Green': MyTheme.fromBaseColors(
      name: 'Green',
      primary: MyThemeProp(name: 'primary', color: Color(0xFF34c759)),
      secondary: MyThemeProp(name: 'secondary', color: Color(0xFFe5ffec)),
    ),

    'Dark Blue': MyTheme.fromBaseColors(
      name: 'Dark Blue',
      primary: MyThemeProp(name: 'primary', color: Color(0xFF5856d6)),
      secondary: MyThemeProp(name: 'secondary', color: Color(0xFFe4e4ff)),
    ),

    'Orange': MyTheme.fromBaseColors(
      name: 'Orange',
      primary: MyThemeProp(name: 'primary', color: Color(0xFFff9500)),
      secondary: MyThemeProp(name: 'secondary', color: Color(0xFFffedd4)),
    ),

    'Red': MyTheme.fromBaseColors(
      name: 'Red',
      primary: MyThemeProp(name: 'primary', color: Color(0xFFff3b30)),
      secondary: MyThemeProp(name: 'secondary', color: Color(0xFFffc7c3)),
    ),

    'Violet': MyTheme.fromBaseColors(
      name: 'Violet',
      primary: MyThemeProp(name: 'primary', color: Color(0xFFaf52de)),
      secondary: MyThemeProp(name: 'secondary', color: Color(0xFFf0d2ff)),
    ),

    'Light Blue': MyTheme.fromBaseColors(
      name: 'Light Blue',
      primary: MyThemeProp(name: 'primary', color: Color(0xFF5ac8fa)),
      secondary: MyThemeProp(name: 'secondary', color: Color(0xFFe8f8ff)),
    ),
  };
}
