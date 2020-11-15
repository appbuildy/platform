import 'package:flutter/cupertino.dart';
import 'package:flutter_app/app_skeleton/loading/screen_load_from_json.dart';
import 'package:flutter_app/shared_widgets/widget_decorator.dart';

class Screen extends StatelessWidget {
  final List<WidgetDecorator> widgets;
  Screen({Key key, this.widgets}) : super(key: key);

  factory Screen.fromJson(Map<String, dynamic> jsonScreen) {
    return ScreenLoadFromJson(jsonScreen).load();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: widgets);
  }
}
