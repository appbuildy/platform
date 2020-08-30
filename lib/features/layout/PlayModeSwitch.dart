import 'package:flutter/material.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_app/ui/MyColors.dart';

class PlayModeSwitch extends StatefulWidget {
  final bool isPlayMode;
  final Function(bool newIsPlayMode) selectPlayMode;

  const PlayModeSwitch({
    @required this.isPlayMode,
    @required this.selectPlayMode,
  });

  @override
  _PlayModeSwitchState createState() => _PlayModeSwitchState();
}

class _PlayModeSwitchState extends State<PlayModeSwitch>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  final animationDuration = Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: animationDuration);
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutQuad);
  }

  @override
  void didUpdateWidget(PlayModeSwitch oldWidget) {
    if (oldWidget.isPlayMode != widget.isPlayMode) {
      widget.isPlayMode ? _controller.forward() : _controller.reverse();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Cursor(
      cursor: CursorEnum.pointer,
      child: Container(
          height: 36,
          decoration: BoxDecoration(
              gradient: MyGradients.mediumBlue,
              borderRadius: BorderRadius.circular(6)),
          child: Stack(
            children: <Widget>[
              AnimatedBuilder(
                animation: _animation,
                builder: (context, _) {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Transform(
                      transform: Matrix4.identity()
                        ..translate(_animation.value * 96),
                      child: Container(
                          decoration: BoxDecoration(
                              color: MyColors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: MyColors.black.withOpacity(0.3),
                                    spreadRadius: 0,
                                    blurRadius: 6,
                                    offset: Offset(0, 2))
                              ],
                              borderRadius: BorderRadius.circular(6)),
                          width: 96),
                    ),
                  );
                },
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        widget.selectPlayMode(false);
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                                'assets/icons/meta/btn-mode-select.svg'),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              'Select',
                              style: MyTextStyle.regularTitle,
                            ),
                          ],
                        )),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        widget.selectPlayMode(true);
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Play',
                              style: MyTextStyle.regularTitle,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Image.network(
                                'assets/icons/meta/btn-mode-play.svg'),
                          ],
                        )),
                      ),
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}
