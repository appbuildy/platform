import 'package:flutter_app/app_skeleton/data_layer/i_element_data.dart';
import 'package:flutter_app/features/entities/Project.dart';
import 'package:flutter_app/shared_widgets/widget_decorator.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';

class WidgetsLoaderForScreen {
  Map<String, dynamic> jsonScreen;
  WidgetsLoaderForScreen(this.jsonScreen);

  List<WidgetDecorator> load(
      {Project project, IElementData elementData, MyTheme theme}) {
    var widgets = jsonScreen['components']
        .map((component) {
          return WidgetDecorator.fromJson(component,
              project: project, elementData: elementData, theme: theme);
        })
        .toList()
        .cast<WidgetDecorator>();

    return widgets;
  }
}
