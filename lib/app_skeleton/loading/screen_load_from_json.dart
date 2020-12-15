import 'package:flutter_app/app_skeleton/screen.dart';
import 'package:flutter_app/shared_widgets/widget_decorator.dart';
import 'package:flutter_app/utils/RandomKey.dart';

import 'i_screen_load.dart';

class ScreenLoadFromJson implements IScreenLoad {
  Map<String, dynamic> jsonScreen;
  ScreenLoadFromJson(this.jsonScreen);

  @override
  Screen load([bottomNavigator]) {
    return Screen(
      id: _id(),
      widgets: _loadWidgets(),
      bottomNavigator: bottomNavigator,
    );
  }

  RandomKey _id() => RandomKey.fromJson(jsonScreen['id']);

  List<WidgetDecorator> _loadWidgets() => jsonScreen['components']
      .map<WidgetDecorator>(
        (component) => WidgetDecorator.fromJson(component),
      )
      .toList();
}
