import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app_skeleton/loading/screen_load_from_json.dart';
import 'package:flutter_app/app_skeleton/previewScreens/fullscreen_app.dart';
import 'package:flutter_app/app_skeleton/previewScreens/phonescreen_with_description_app.dart';
import 'package:flutter_app/app_skeleton/previewScreens/phonescreen_app.dart';
import 'package:flutter_app/app_skeleton/widgets/bottom_navigation.dart';
import 'package:flutter_app/features/entities/Project.dart';
import 'package:flutter_app/shared_widgets/widget_decorator.dart';
import 'package:flutter_app/store/schema/DetailedInfo.dart';
import 'package:flutter_app/utils/RandomKey.dart';

class Screen extends StatelessWidget {
  final List<WidgetDecorator> widgets;
  final RandomKey id;
  final BottomNavigation bottomNavigation;
  final DetailedInfo detailedInfo;

  Screen(
      {Key key,
      this.widgets,
      this.id,
      this.bottomNavigation,
      this.detailedInfo})
      : super(key: key);

  factory Screen.fromJson(Map<String, dynamic> jsonScreen,
      {BottomNavigation bottomNavigation, Project project}) {
    return ScreenLoadFromJson(jsonScreen).load(bottomNavigation, project);
  }

  @override
  Widget build(BuildContext context) {
    var nav = bottomNavigation;
    final double navHeight = 84;

    double screenHeightInConstructor = 812;
    double screenWidthInConstructor = 375;

    Size currentScreenSize = MediaQuery.of(context).size;

    Widget screen;

    if (currentScreenSize.width > 0 && currentScreenSize.width < 600) {
      screen = Fullscreen(
        targetScreenSize: currentScreenSize,
        screenSizeInConstructor:
            Size(screenWidthInConstructor, screenHeightInConstructor),
        navHeight: navHeight,
        widgets: widgets,
        nav: nav,
      );
    }

    if (currentScreenSize.width >= 600 && currentScreenSize.width < 800) {
      screen = Center(
        child: PhoneScreen(
          targetScreenSize:
              Size(currentScreenSize.width, currentScreenSize.height - 30),
          screenSizeInConstructor:
              Size(screenWidthInConstructor, screenHeightInConstructor),
          navHeight: navHeight,
          widgets: widgets,
          nav: nav,
        ),
      );
    }

    if (currentScreenSize.width >= 800) {
      screen = PhoneScreenWithDescription(
        targetScreenSize:
            Size(currentScreenSize.width, currentScreenSize.height - 30),
        screenSizeInConstructor:
            Size(screenWidthInConstructor, screenHeightInConstructor),
        navHeight: navHeight,
        widgets: widgets,
        nav: nav,
      );
    }

    return Scaffold(
      body: screen,
    );
  }
}
