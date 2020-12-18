import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app_skeleton/entities/skeleton_screen.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/utils/RandomKey.dart';

class ScalingScreenScaffold extends StatelessWidget {
  final SkeletonScreen screen;

  ScalingScreenScaffold({
    Key key,
    this.screen,
  }) : super(key: key);

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
                aspectRatio: screen.showNavBar
                    ? screen.screenSize.bodyAspectRatio
                    : screen.screenSize.boxAspectRatio,
                //! scales to fit given constraints
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  //! coords will be exactly as in build screen
                  child: SizedBox(
                    width: screen.screenSize.boxWidth,
                    height: screen.showNavBar
                        ? screen.screenSize.bodyHeight
                        : screen.screenSize.boxHeight,
                    child: Stack(
                      clipBehavior: Clip.none,
                      //! empty stack should still be fine
                      children: screen.widgets ?? [],
                    ),
                  ),
                ),
              ),
            ),
          ),
          //! bottom navigator stretched to fill the whole width
          if (screen.showNavBar) screen.navBar,
        ],
      ),
    );
  }
}
