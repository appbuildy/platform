import 'package:flutter_app/app_skeleton/screen.dart';
import 'package:flutter_app/shared_widgets/widget_decorator.dart';
import 'package:flutter_app/store/schema/DetailedInfo.dart';
import 'package:flutter_app/utils/RandomKey.dart';

import 'i_screen_load.dart';

class ScreenLoadFromJson implements IScreenLoad {
  Map<String, dynamic> jsonScreen;
  ScreenLoadFromJson(this.jsonScreen);

  @override
  Screen load([bottomNavigation, project]) {
    return Screen(
      bottomNavigation: bottomNavigation,
      bottomTabsVisible: jsonScreen['bottomTabsVisible'],
      id: _id(),
      detailedInfo: _loadDetailedInfo(),
        widgets: _loadWidgets(project),
    );
  }

  RandomKey _id() {
    return RandomKey.fromJson(jsonScreen['id']);
  }

  _loadDetailedInfo() {
    return DetailedInfo.fromJson(jsonScreen['detailedInfo']);
  }

  List<WidgetDecorator> _loadWidgets(project) {
    var widgets = jsonScreen['components']
        .map((component) {
          return WidgetDecorator.fromJson(component, project);
        })
        .toList()
        .cast<WidgetDecorator>();

    return widgets;
  }
}
