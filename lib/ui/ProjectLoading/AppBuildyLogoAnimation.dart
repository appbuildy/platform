import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppBuildyLogoAnimation extends StatefulWidget {
  @override
  _AppBuildyLogoAnimationState createState() => _AppBuildyLogoAnimationState();
}

class _AppBuildyLogoAnimationState extends State<AppBuildyLogoAnimation>
    with TickerProviderStateMixin {
  AnimationController _controller;
  int scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'lottie_animations/loading.json',
      width: 150,
      height: 150,
      fit: BoxFit.fill,
      controller: _controller,
      onLoaded: (composition) {
        _controller
          ..duration = Duration(milliseconds: 1250)
          ..forward()
          ..addStatusListener(
            (status) {
              if (status == AnimationStatus.completed) {
                _controller.value = 0;
              } else if (status == AnimationStatus.dismissed) {
                _controller.forward();
              }
            },
          );
      },
    );
  }
}
