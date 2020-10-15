import 'package:flutter/material.dart';
import 'package:flutter_app/ui/Cursor.dart';

import 'MyColors.dart';

class MySwitch extends StatefulWidget {
  final bool value;
  final Function onTap;

  const MySwitch({
    Key key,
    @required this.value,
    @required this.onTap,
  }) : super(key: key);

  @override
  _MySwitchState createState() => _MySwitchState();
}

class _MySwitchState extends State<MySwitch>
    with SingleTickerProviderStateMixin {
  final Color activeColor = MyColors.black;
  final Color inactiveColor = Color(0xFFCCCCCC);
  Animation _circleAnimation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    _circleAnimation = AlignmentTween(
            begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
            end: widget.value ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.easeInOutQuad));
  }

  @override
  void didUpdateWidget(MySwitch oldWidget) {
    if (oldWidget.value != widget.value) {
      _circleAnimation.isCompleted
          ? _animationController.reverse()
          : _animationController.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Cursor(
      cursor: CursorEnum.pointer,
      child: GestureDetector(
        onTap: () {
          widget.onTap();
        },
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: AnimatedBuilder(
            animation: _circleAnimation,
            builder: (context, child) {
              return Container(
                width: 43.0,
                height: 23.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11.5),
                  color: _circleAnimation.value == Alignment.centerLeft
                      ? Color(0xffaab5c8)
                      : MyColors.mainBlue,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _circleAnimation.value == Alignment.centerRight
                          ? Spacer()
                          : Container(),
                      Align(
                        alignment: _circleAnimation.value,
                        child: Container(
                          width: 21.0,
                          height: 21.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: MyColors.white,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 4,
                                    spreadRadius: 0,
                                    offset: Offset(0, 1),
                                    color: MyColors.black.withOpacity(0.2))
                              ]),
                        ),
                      ),
                      _circleAnimation.value == Alignment.centerLeft
                          ? Spacer()
                          : Container(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
