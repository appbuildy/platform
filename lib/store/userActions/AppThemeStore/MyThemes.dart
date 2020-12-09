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

  MyThemeProp.fromJson(Map<String, dynamic> targetJson) {
    this.color = Color.fromRGBO(targetJson['red'], targetJson['green'],
        targetJson['blue'], targetJson['opacity']);
    this.name = targetJson['name'];
  }

  Map<String, dynamic> toJson() {
    return {
      'red': color.red,
      'green': color.green,
      'blue': color.blue,
      'opacity': color.opacity,
      'name': name
    };
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

  MyTheme.fromJson(Map<String, dynamic> targetJson) {
    this.name = targetJson['name'];
    this.primary = MyThemeProp.fromJson(targetJson['primary']);
    this.secondary = MyThemeProp.fromJson(targetJson['secondary']);
    this.general = MyThemeProp.fromJson(targetJson['general']);
    this.generalSecondary =
        MyThemeProp.fromJson(targetJson['general_secondary']);
    this.generalInverted = MyThemeProp.fromJson(targetJson['general_inverted']);
    this.separators = MyThemeProp.fromJson(targetJson['separators']);
    this.background = MyThemeProp.fromJson(targetJson['background']);
  }

  Map<String, dynamic> get props => {
        'primary': primary,
        'secondary': secondary,
        'general': general,
        'general_secondary': generalSecondary,
        'general_inverted': generalInverted,
        'separators': separators,
        'background': background
      };

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'primary': primary.toJson(),
      'secondary': secondary.toJson(),
      'general': general.toJson(),
      'general_secondary': generalSecondary.toJson(),
      'general_inverted': generalInverted.toJson(),
      'separators': separators.toJson(),
      'background': background.toJson()
    };
  }

  MyThemeProp getThemePropByName(String name) {
    return props[name] ?? primary;
  }

  List<MyThemeProp> getAllColors() {
    return [
      this.primary,
      this.secondary,
      this.general,
      this.generalSecondary,
      this.generalInverted,
      this.separators,
      this.background,
    ];
  }

  MyTheme(
      {@required this.name,
      @required this.primary,
      @required this.secondary,
      @required this.general,
      @required this.generalSecondary,
      @required this.generalInverted,
      @required this.separators,
      @required this.background})
      : super();

  MyTheme.fromBaseColors(
      {@required String name,
      @required MyThemeProp primary,
      @required MyThemeProp secondary})
      : super() {
    this.name = name;
    this.primary = primary;
    this.secondary = secondary;
    this.general = MyThemeProp(name: 'general', color: Color(0xFF111111));
    this.generalSecondary =
        MyThemeProp(name: 'general_secondary', color: Color(0xFF808080));
    this.generalInverted =
        MyThemeProp(name: 'general_inverted', color: Color(0xFFf9f9f9));
    this.separators = MyThemeProp(name: 'separators', color: Color(0xFFC2C2C6));
    this.background = MyThemeProp(name: 'background', color: Color(0xFFffffff));
  }
}

class MyThemes {
  static Map<String, MyTheme> allThemes = {
    'blue': MyTheme.fromBaseColors(
      name: 'Blue',
      primary: MyThemeProp(name: 'primary', color: Color(0xFF007aff)),
      secondary: MyThemeProp(name: 'secondary', color: Color(0xFFd2e7ff)),
    ),
    'monochrome': MyTheme.fromBaseColors(
      name: 'Monochrome',
      primary: MyThemeProp(name: 'primary', color: Color(0xFF5f5f5f)),
      secondary: MyThemeProp(name: 'secondary', color: Color(0xFFececec)),
    ),
    'green': MyTheme.fromBaseColors(
      name: 'Green',
      primary: MyThemeProp(name: 'primary', color: Color(0xFF34c759)),
      secondary: MyThemeProp(name: 'secondary', color: Color(0xFFe5ffec)),
    ),
    'darkBlue': MyTheme.fromBaseColors(
      name: 'Dark Blue',
      primary: MyThemeProp(name: 'primary', color: Color(0xFF5856d6)),
      secondary: MyThemeProp(name: 'secondary', color: Color(0xFFe4e4ff)),
    ),
    'orange': MyTheme.fromBaseColors(
      name: 'Orange',
      primary: MyThemeProp(name: 'primary', color: Color(0xFFff9500)),
      secondary: MyThemeProp(name: 'secondary', color: Color(0xFFffedd4)),
    ),
    'red': MyTheme.fromBaseColors(
      name: 'Red',
      primary: MyThemeProp(name: 'primary', color: Color(0xFFff3b30)),
      secondary: MyThemeProp(name: 'secondary', color: Color(0xFFffc7c3)),
    ),
    'violet': MyTheme.fromBaseColors(
      name: 'Violet',
      primary: MyThemeProp(name: 'primary', color: Color(0xFFaf52de)),
      secondary: MyThemeProp(name: 'secondary', color: Color(0xFFf0d2ff)),
    ),
    'lightBlue': MyTheme.fromBaseColors(
      name: 'Light Blue',
      primary: MyThemeProp(name: 'primary', color: Color(0xFF5ac8fa)),
      secondary: MyThemeProp(name: 'secondary', color: Color(0xFFe8f8ff)),
    ),
  };
}
