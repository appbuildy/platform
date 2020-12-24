import 'package:flutter/material.dart';
import 'package:flutter_app/app_skeleton/previewScreens/phonescreen_app.dart';
import 'package:flutter_app/shared_widgets/widget_decorator.dart';

class PhoneScreenWithDescription extends StatelessWidget {
  final Size targetScreenSize;
  final Size screenSizeInConstructor;
  final double navHeight;
  final Widget nav;
  final List<WidgetDecorator> widgets;

  PhoneScreenWithDescription({
    @required this.targetScreenSize,
    @required this.screenSizeInConstructor,
    @required this.navHeight,
    @required this.nav,
    @required this.widgets,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          child: Center(
            child: Container(
              width: screenSizeInConstructor.width * 2,
              child: Row(
                children: [
                  PhoneScreen(
                    targetScreenSize: targetScreenSize,
                    screenSizeInConstructor: screenSizeInConstructor,
                    navHeight: navHeight,
                    nav: nav,
                    widgets: widgets,
                  ),
                  SizedBox(width: 10),
                  Flexible(child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut ut felis odio. Aliquam vulputate pellentesque tellus sollicitudin laoreet. Nunc libero metus, aliquam ut neque sed, tincidunt aliquet urna. Phasellus in arcu in nisi semper rhoncus. Aliquam quis feugiat velit, ac suscipit felis. Vestibulum fringilla arcu vitae ante hendrerit efficitur. Phasellus viverra at urna quis commodo. Suspendisse quam libero, lobortis sit amet dapibus eu, lacinia at lorem.')),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 15,
          right: 15,
          child: Text('THIS IS QR CODE'),
        ),
        Positioned(
          bottom: 15,
          right: 15,
          child: Text('mAkE yOuR ApP'),
        ),
      ],
    );
  }
}
