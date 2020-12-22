part of 'app_loader.dart';

class LoaderAnimatedLogo extends StatefulWidget {
  @override
  _LoaderAnimatedLogoState createState() => _LoaderAnimatedLogoState();
}

class _LoaderAnimatedLogoState extends State<LoaderAnimatedLogo>
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
      width: appConst.loaderLogoSize,
      height: appConst.loaderLogoSize,
      fit: BoxFit.fill,
      controller: _controller,
      onLoaded: (LottieComposition composition) {
        _controller
          ..duration = Duration(milliseconds: 1250)
          ..forward()
          ..addStatusListener(
            (AnimationStatus status) {
              if (status == AnimationStatus.completed) {
                _controller.value = 0;
              }
              if (status == AnimationStatus.dismissed) {
                _controller.forward();
              }
            },
          );
      },
    );
  }
}
