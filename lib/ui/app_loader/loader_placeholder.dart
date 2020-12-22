part of 'app_loader.dart';

class LoaderPlaceholder extends StatefulWidget {
  @override
  _LoaderPlaceholderState createState() => _LoaderPlaceholderState();
}

class _LoaderPlaceholderState extends State<LoaderPlaceholder>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget child) => Transform.scale(
                scale: _animation.value,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LoaderAnimatedLogo(),
                      SizedBox(height: 20.0),
                      Text('Making it shine...',
                          style: TextStyle(
                            color: MyColors.black,
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                          )),
                    ]),
              )),
    );
  }
}
