import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app_skeleton/actions/detailed_screen_navigaton.dart';
import 'package:flutter_app/app_skeleton/application.dart';
import 'package:flutter_app/app_skeleton/data_layer/i_element_data.dart';
import 'package:flutter_app/app_skeleton/data_provider/created_data_provider_record.dart';
import 'package:flutter_app/app_skeleton/screen.dart';
import 'package:flutter_app/features/entities/Project.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/serialization/component_properties.dart';
import 'package:flutter_app/shared_widgets/button.dart';
import 'package:flutter_app/shared_widgets/form.dart' as shared_widgets;
import 'package:flutter_app/shared_widgets/icon.dart' as shared_widgets;
import 'package:flutter_app/shared_widgets/image.dart' as shared_widgets;
import 'package:flutter_app/shared_widgets/list.dart' as shared_widgets;
import 'package:flutter_app/shared_widgets/map_view.dart';
import 'package:flutter_app/shared_widgets/shape.dart';
import 'package:flutter_app/shared_widgets/text.dart' as shared_widgets;
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';

class WidgetDecorator extends StatelessWidget {
  const WidgetDecorator(
      {Key key, this.onTap, this.widget, this.position, this.props})
      : super(key: key);

  final Widget Function(BuildContext) widget;
  final Offset position;
  final Function onTap;
  final Map<String, SchemaNodeProperty> props;

  factory WidgetDecorator.fromJson(Map<String, dynamic> jsonComponent,
      {Project project, IElementData elementData, MyTheme theme}) {
    var currentTheme = theme ?? MyThemes.allThemes['blue'];
    //todo: add schemaNodeSpawner to args
    var componentProperties =
        ComponentProperties(jsonComponent, elementData: elementData);

    var previewActions = componentProperties.previewActions;

    switch (jsonComponent['type']) {
      case 'SchemaNodeType.button':
        {
          return WidgetDecorator(
              onTap: previewActions['Tap'].functionAction,
              position: componentProperties.position,
              widget: (context) => Button(
                  onTap: () {
                    previewActions['Tap'].functionAction(context)();
                  },
                  properties: componentProperties.properties,
                  size: componentProperties.size,
                  theme: currentTheme));
        }
        break;
      case 'SchemaNodeType.text':
        {
          return WidgetDecorator(
              onTap: previewActions['Tap'].functionAction,
              position: componentProperties.position,
              widget: (context) => shared_widgets.Text(
                  properties: componentProperties.properties,
                  size: componentProperties.size,
                  theme: currentTheme));
        }
        break;

      case 'SchemaNodeType.shape':
        {
          return WidgetDecorator(
              onTap: previewActions['Tap'].functionAction,
              position: componentProperties.position,
              widget: (context) => Shape(
                  properties: componentProperties.properties,
                  size: componentProperties.size,
                  theme: currentTheme));
        }
        break;

      case 'SchemaNodeType.map':
        {
          return WidgetDecorator(
              onTap: previewActions['Tap'].functionAction,
              position: componentProperties.position,
              widget: (context) => MapView(
                  properties: componentProperties.properties,
                  size: componentProperties.size,
                  theme: currentTheme));
        }
        break;

      case 'SchemaNodeType.icon':
        {
          return WidgetDecorator(
              onTap: previewActions['Tap'].functionAction,
              position: componentProperties.position,
              widget: (context) => shared_widgets.Icon(
                  properties: componentProperties.properties,
                  size: componentProperties.size,
                  theme: currentTheme));
        }
        break;

      case 'SchemaNodeType.list':
        {
          return WidgetDecorator(
              onTap: previewActions['Tap'].functionAction,
              position: componentProperties.position,
              props: componentProperties.properties,
              widget: (context) => shared_widgets.List(
                  project: project,
                  properties: componentProperties.properties,
                  onListItemClick: (value) {
                    Screen screen = Application.allScreens[
                        previewActions['Tap'].metadata['screenKey']];
                    DetailedScreenNavigation(
                            targetScreen: screen,
                            valuesForScreen: value,
                            project: project)
                        .navigate(context);
                  },
                  isBuild: true,
                  size: componentProperties.size,
                  theme: currentTheme));
        }
        break;
      case 'SchemaNodeType.image':
        {
          return WidgetDecorator(
              onTap: previewActions['Tap'].functionAction,
              position: componentProperties.position,
              widget: (context) => shared_widgets.Image(
                  properties: componentProperties.properties,
                  size: componentProperties.size,
                  theme: currentTheme));
        }
        break;
      case 'SchemaNodeType.form':
        {
          var dataProvider = CreatedDataProviderRecord.airtable(
              componentProperties.properties['Table'].value);

          return WidgetDecorator(
              onTap: () => {},
              position: componentProperties.position,
              widget: (context) => shared_widgets.Form(
                  properties: componentProperties.properties,
                  onCreate: dataProvider.create,
                  size: componentProperties.size,
                  theme: currentTheme));
        }
    }
    return WidgetDecorator(
        onTap: previewActions['Tap'].functionAction,
        position: componentProperties.position,
        widget: (context) => shared_widgets.Image(
            properties: componentProperties.properties,
            size: componentProperties.size,
            theme: currentTheme));
  }

  _onTap(context) {
    try {
      var fun = onTap ?? (context) => () => {};
      return fun(context);
    } catch (e) {
      print('failed to load onTap');
      return () => {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: position.dx,
        top: position.dy,
        child: GestureDetector(
            onTap: _onTap(context), child: this.widget(context)));
  }
}
