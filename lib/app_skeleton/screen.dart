import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app_skeleton/loading/screen_load_from_json.dart';
import 'package:flutter_app/app_skeleton/widgets/bottom_navigation.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/features/entities/Project.dart';
import 'package:flutter_app/shared_widgets/widget_decorator.dart';
import 'package:flutter_app/utils/RandomKey.dart';

class Screen extends StatelessWidget {
  final List<WidgetDecorator> widgets;
  final RandomKey id;
  final BottomNavigation bottomNavigation;

  Screen({
    Key key,
    this.widgets,
    this.id,
    this.bottomNavigation,
  }) : super(key: key);

  //! add , after the last argument for better readability in long args lists
  //! formatter will add linewraps by itself
  factory Screen.fromJson(
    Map<String, dynamic> jsonScreen, {
    BottomNavigation bottomNavigation,
    Project project,
  }) {
    return ScreenLoadFromJson(jsonScreen).load(
      bottomNavigation,
      project,
    );
  }

  bool get showBottomNavBar => bottomNavigation != null;
  @override
  Widget build(BuildContext context) {
    //! we could just add conditional in the column builder
    // var nav = bottomNavigation ?? Container();

    //! made global constants instead
    // double screenHeightInConstructor = 812;
    // double screenWidthInConstructor = 375;

    //! better and more reliable to use LayoutBuilder here
    // var currentScreenSize = MediaQuery.of(context).size;

    // double screenHeight = currentScreenSize.height;
    // double screenWidth = currentScreenSize.width;

    //! there is a  FittedBox widget which actually scales its content to fill
    //! availalbe space
    // double scaleFactor = screenWidth / screenWidthInConstructor;

    //! got em from constants
    // final double navHeight = 84;

    // final double heightWithoutNavigationFromConstructor =
    //     (screenHeightInConstructor - navHeight) * scaleFactor;
    // final double heightWithoutNavigationFromCurrentScreen =
    //     screenHeight - navHeight;

    return Scaffold(
      body: Column(
        //! why start when we want to stretch content to fill the screen?
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //! expanded fixes size to all available space that is left after
          //! other children laid themselves
          Expanded(
            child: SingleChildScrollView(
              //! added this so we have constrained box
              child: AspectRatio(
                aspectRatio: showBottomNavBar
                    ? screenConst.bodyAspectRatio
                    : screenConst.phoneBoxAspectRatio,
                //! scales to fit given constraints
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  //! coords will be exactly as in build screen
                  child: SizedBox(
                    width: screenConst.phoneBoxWidth,
                    height: showBottomNavBar
                        ? screenConst.bodyHeight
                        : screenConst.phoneBoxHeight,
                    child: Stack(
                      clipBehavior: Clip.none,
                      //! empty stack should still be fine
                      children: widgets ?? [],
                    ),
                  ),
                ),
              ),
            ),
          ),
          //! bottom navigator stretched to fill the whole width
          if (showBottomNavBar) bottomNavigation,
        ],
      ),
    );
  }
}
