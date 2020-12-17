import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app_skeleton/loading/screen_load_from_json.dart';
import 'package:flutter_app/app_skeleton/widgets/bottom_navigation.dart';
import 'package:flutter_app/shared_widgets/widget_decorator.dart';
import 'package:flutter_app/utils/RandomKey.dart';

class Screen extends StatelessWidget {
  final List<WidgetDecorator> widgets;
  final RandomKey id;
  final BottomNavigation bottomNavigation;
  Screen({Key key, this.widgets, this.id, this.bottomNavigation})
      : super(key: key);

  factory Screen.fromJson(Map<String, dynamic> jsonScreen,
      {BottomNavigation bottomNavigation}) {
    return ScreenLoadFromJson(jsonScreen).load(bottomNavigation);
  }

  @override
  Widget build(BuildContext context) {
    var nav = bottomNavigation ?? Container();

    double screenHeightInConstructor = 812;
    double screenWidthInConstructor = 375;

    var currentScreenSize = MediaQuery.of(context).size;

    double screenHeight = currentScreenSize.height;
    double screenWidth = currentScreenSize.width;

    double scaleFactor = screenWidth / screenWidthInConstructor;

    final double navHeight = 84;

    final double heightWithoutNavigationFromConstructor = (screenHeightInConstructor - navHeight) * scaleFactor;
    final double heightWithoutNavigationFromCurrentScreen = screenHeight - navHeight;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: heightWithoutNavigationFromCurrentScreen,
            child: SingleChildScrollView(
              child: Container(
                width: screenWidth,
                height: heightWithoutNavigationFromConstructor > heightWithoutNavigationFromCurrentScreen ? heightWithoutNavigationFromConstructor : heightWithoutNavigationFromCurrentScreen,
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
                child: Transform.scale(
                  alignment: AlignmentDirectional.topStart,
                  scale: scaleFactor,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(),
                      ...widgets,
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: screenWidth,
            child: nav,
          ),
        ],
      ),
    );
  }
}
