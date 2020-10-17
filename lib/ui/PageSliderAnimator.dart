import 'package:flutter/material.dart';

import 'MyColors.dart';

class PageSliderController<T> {
  Animation animation;
  AnimationController controller;

  Widget rootPage;
  Map<T, Widget> pagesMap;
  TickerProvider vsync;

  bool _isPageSelected = false;
  Widget _selectedPage;

  PageSliderController({
    @required vsync,
    @required rootPage,
    @required pagesMap,
  }) {
    this.controller = AnimationController(
        value: 1,
        vsync: vsync,
        duration: Duration(milliseconds: 250),
    );

    this.animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOutQuad,
      reverseCurve: Curves.easeInOutQuad,
    );

    this.rootPage = rootPage;
    this.pagesMap = pagesMap;
  }

  Widget getSelectedPage() => _selectedPage;

  void to(T) {
    _selectedPage = pagesMap[T];
    _isPageSelected = true;

    controller.reverse();
  }

  void toRoot() {
    _isPageSelected = false;

    controller.forward();

    Future.delayed(Duration(milliseconds: 200), () {
      if (!_isPageSelected) {
        _selectedPage = null;
      }
    });
  }

  void updatePage(T, Widget updatedWidget) {
    pagesMap[T] = updatedWidget;
    _selectedPage = pagesMap[T];
  }
}

class PageSliderAnimator extends StatelessWidget {
  final int maxSlide;
  final double slidesWidth;
  final PageSliderController pageSliderController;

  PageSliderAnimator({
    @required this.pageSliderController,
    @required this.maxSlide,
    @required this.slidesWidth,
  });


  Widget buildMain(slideFirst, slideSecond) {
    return Stack(
      children: [
        Positioned(
          child: Transform(
              transform: Matrix4.identity()..translate(slideFirst),
              child: pageSliderController.animation.value < 0.4
                  ? Container()
                  : Container(
                      color: MyColors.white,
                      width: slidesWidth,
                      child: pageSliderController.rootPage,
                  ),
          ),
        ),
        Positioned(
          child: Transform(
              transform: Matrix4.identity()..translate(slideSecond),
              child: pageSliderController.animation.value == 1
                  ? Container()
                  : Container(
                      color: MyColors.white,
                      width: slidesWidth,
                      child: pageSliderController.getSelectedPage(),
                  ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (BuildContext context, Widget child) {
        double reversedValue = (pageSliderController.animation.value - 1) * -1;
        double slideFirst = (-maxSlide / 2) * reversedValue;
        double slideSecond = maxSlide * (pageSliderController.animation.value);

        if (pageSliderController.animation.value > 0.09 && pageSliderController.animation.value < 0.8) {
          return Container(
            child: ClipRect(
              child: buildMain(slideFirst, slideSecond),
            ),
          );
        }

        return Container(
          child: buildMain(slideFirst, slideSecond),
        );
      },
      animation: pageSliderController.animation,
    );
  }
}