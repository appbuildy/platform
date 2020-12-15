import 'package:flutter/material.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/ProjectLoading/AppBuildyLogoAnimation.dart';

class ProjectLoadingAnimation extends StatefulWidget {
  @override
  _ProjectLoadingAnimationState createState() =>
      _ProjectLoadingAnimationState();
}

class _ProjectLoadingAnimationState extends State<ProjectLoadingAnimation>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: AnimatedBuilder(
            builder: (BuildContext context, Widget child) {
              return Transform.scale(
                scale: _animation.value,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppBuildyLogoAnimation(),
                    SizedBox(height: 20.0),
                    Text(
                      'Making it shine...',
                      style: TextStyle(
                        color: MyColors.black,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
            animation: _controller,
          ),
        ),
      ),
    );
  }
}
