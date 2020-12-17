import 'package:flutter_app/app_skeleton/loading/i_loader.dart';
import 'package:flutter_app/app_skeleton/screen.dart';
import 'package:flutter_app/shared_widgets/widget_decorator.dart';
import 'package:flutter_app/utils/RandomKey.dart';

class ScreenLoadFromJson implements ILoader<Screen> {
  Map<String, dynamic> jsonScreen;
  ScreenLoadFromJson(this.jsonScreen);

  @override
  Screen load([bottomNavigation]) {
    return Screen(
      bottomNavigation: bottomNavigation,
      id: _id(),
      widgets: _loadWidgets(),
    );
  }

  RandomKey _id() {
    return RandomKey.fromJson(jsonScreen['id']);
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
