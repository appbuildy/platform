import 'package:flutter/cupertino.dart';
import 'package:flutter_app/shared_widgets/widget_decorator.dart';

class Screen extends StatelessWidget {
  final List<WidgetDecorator> widgets;
  Screen({Key key, this.widgets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: widgets);
  }
}
