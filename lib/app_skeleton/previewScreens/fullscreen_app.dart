import 'package:flutter/material.dart';
import 'package:flutter_app/shared_widgets/widget_decorator.dart';

class Fullscreen extends StatelessWidget {
  final Size targetScreenSize;
  final Size screenSizeInConstructor;
  final double navHeight;
  final Widget nav;
  final List<WidgetDecorator> widgets;

  Fullscreen({
    @required this.targetScreenSize,
    @required this.screenSizeInConstructor,
    @required this.navHeight,
    @required this.nav,
    @required this.widgets,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = targetScreenSize.height;
    double screenWidth = targetScreenSize.width;

    double scaleFactor = screenWidth / screenSizeInConstructor.width;

    final double heightWithoutNavigationFromConstructor = (screenSizeInConstructor.height - navHeight) * scaleFactor;
    final double heightWithoutNavigationFromCurrentScreen = screenHeight - navHeight;


    double height = heightWithoutNavigationFromConstructor > heightWithoutNavigationFromCurrentScreen ? heightWithoutNavigationFromConstructor : heightWithoutNavigationFromCurrentScreen;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: heightWithoutNavigationFromCurrentScreen + (nav == null ? navHeight : 0),
          child: SingleChildScrollView(
            child: Container(
              width: screenWidth,
              height: height,
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
    );
  }
}
