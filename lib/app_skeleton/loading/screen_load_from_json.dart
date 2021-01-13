import 'package:flutter_app/app_skeleton/data_layer/data_from_detailed_info.dart';
import 'package:flutter_app/app_skeleton/data_layer/i_element_data.dart';
import 'package:flutter_app/app_skeleton/screen.dart';
import 'package:flutter_app/shared_widgets/widget_decorator.dart';
import 'package:flutter_app/store/schema/DetailedInfo.dart';
import 'package:flutter_app/utils/RandomKey.dart';

import 'i_screen_load.dart';

class ScreenLoadFromJson implements IScreenLoad {
  Map<String, dynamic> jsonScreen;
  ScreenLoadFromJson(this.jsonScreen);

  @override
  Screen load([bottomNavigation, project, IElementData elementData]) {
    return Screen(
      bottomNavigation: bottomNavigation,
      bottomTabsVisible: jsonScreen['bottomTabsVisible'],
      id: _id(),
      widgets: _loadWidgets(project, DataFromDetailedInfo(_loadDetailedInfo())),
    );
  }

  RandomKey _id() {
    return RandomKey.fromJson(jsonScreen['id']);
  }

  _loadDetailedInfo() {
    if (jsonScreen['detailedInfo'] == null ||
        jsonScreen['detailedInfo']['rowData'] == null) {
      return null;
    }
    return DetailedInfo.fromJson(jsonScreen['detailedInfo']);
  }

  List<WidgetDecorator> _loadWidgets(project, elementData) {
    var widgets = jsonScreen['components']
        .map((component) {
          return WidgetDecorator.fromJson(component,
              project: project, elementData: elementData);
        })
        .toList()
        .cast<WidgetDecorator>();

    return widgets;
  }
}
