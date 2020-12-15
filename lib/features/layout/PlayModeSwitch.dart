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

  final animationDuration = Duration(milliseconds: 250);

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
      child: DecoratedBox(
          decoration: BoxDecoration(
              gradient: MyGradients.mediumBlue,
              borderRadius: BorderRadius.circular(6)),
          child: Stack(
            children: <Widget>[
              AnimatedBuilder(
                animation: _animation,
                builder: (context, _) {
                  return Transform(
                    transform: Matrix4.identity()
                      ..translate(_animation.value * 90),
                    child: Container(
                      margin: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: MyColors.white,
                        boxShadow: [
                          BoxShadow(
                            color: MyColors.black.withOpacity(0.3),
                            spreadRadius: 0,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          )
                        ],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      width: 88,
                    ),
                  );
                },
              ),
              Positioned.fill(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          widget.selectPlayMode(false);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Image.network(
                                'assets/icons/meta/btn-mode-select.svg',
                                height: 18,
                                width: 18,
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Select',
                                  overflow: TextOverflow.ellipsis,
                                  style: MyTextStyle.regularTitle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          widget.selectPlayMode(true);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'Play',
                                  style: MyTextStyle.regularTitle,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Image.network(
                                'assets/icons/meta/btn-mode-play.svg',
                                height: 18,
                                width: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
