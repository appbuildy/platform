import 'package:flutter/cupertino.dart';

class WidgetDecorator extends StatelessWidget {
  const WidgetDecorator({Key key, this.widget, this.position})
      : super(key: key);

  final Widget widget;
  final Offset position;

  @override
  Widget build(BuildContext context) {
    return Positioned(child: this.widget, left: position.dx, top: position.dy);
  }
}
