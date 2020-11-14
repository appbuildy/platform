import 'package:flutter_app/app_skeleton/screen.dart';
import 'package:flutter_app/shared_widgets/widget_decorator.dart';

import 'i_screen_load.dart';

class ScreenLoadFromJson implements IScreenLoad {
  Map<String, dynamic> jsonScreen;
  ScreenLoadFromJson(this.jsonScreen);

  @override
  Screen load() {
    return Screen(widgets: _loadWidgets());
  }

  List<WidgetDecorator> _loadWidgets() {
    var widgets = jsonScreen['components']
        .map((component) {
          return WidgetDecorator.fromJson(component);
        })
        .toList()
        .cast<WidgetDecorator>();

    return widgets;
  }
}
