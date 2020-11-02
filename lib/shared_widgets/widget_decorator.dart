import 'package:flutter/cupertino.dart';

class WidgetDecorator extends StatelessWidget {
  const WidgetDecorator({Key key, this.onTap, this.widget, this.position})
      : super(key: key);

  final Widget widget;
  final Offset position;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: position.dx,
        top: position.dy,
        child: GestureDetector(onTap: onTap, child: this.widget));
  }
}
