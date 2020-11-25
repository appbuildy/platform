import 'package:flutter/cupertino.dart';
import 'package:flutter_app/serialization/component_properties.dart';
import 'package:flutter_app/shared_widgets/button.dart';
import 'package:flutter_app/shared_widgets/shape.dart';
import 'package:flutter_app/shared_widgets/text.dart' as shared_widgets;
import 'package:flutter_app/shared_widgets/icon.dart' as shared_widgets;
import 'package:flutter_app/shared_widgets/image.dart' as shared_widgets;
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';

class WidgetDecorator extends StatelessWidget {
  const WidgetDecorator({Key key, this.onTap, this.widget, this.position})
      : super(key: key);

  final Widget widget;
  final Offset position;
  final Function onTap;

  factory WidgetDecorator.fromJson(Map<String, dynamic> jsonComponent) {
    var theme = MyThemes.allThemes['blue'];
    //todo: add schemaNodeSpawner to args
    var componentProperties = ComponentProperties(jsonComponent);

    switch (jsonComponent['type']) {
      case 'SchemaNodeType.button':
        {
          return WidgetDecorator(
              onTap: () => {},
              position: componentProperties.position,
              widget: Button(
                  properties: componentProperties.properties,
                  size: componentProperties.size,
                  theme: theme));
        }
        break;
      case 'SchemaNodeType.text':
        {
          return WidgetDecorator(
              onTap: () => {},
              position: componentProperties.position,
              widget: shared_widgets.Text(
                  properties: componentProperties.properties,
                  size: componentProperties.size,
                  theme: theme));
        }
        break;

      case 'SchemaNodeType.shape':
        {
          return WidgetDecorator(
              onTap: () => {},
              position: componentProperties.position,
              widget: Shape(
                  properties: componentProperties.properties,
                  size: componentProperties.size,
                  theme: theme));
        }
        break;

      case 'SchemaNodeType.icon':
        {
          return WidgetDecorator(
              onTap: () => {},
              position: componentProperties.position,
              widget: shared_widgets.Icon(
                  properties: componentProperties.properties,
                  size: componentProperties.size,
                  theme: theme));
        }
        break;

      case 'SchemaNodeType.list':
        {
          return WidgetDecorator(
              onTap: () => {},
              position: componentProperties.position,
              widget: Button(
                  properties: componentProperties.properties,
                  size: componentProperties.size,
                  theme: theme));
        }
        break;
      case 'SchemaNodeType.image':
        return WidgetDecorator(
            onTap: () => {},
            position: componentProperties.position,
            widget: shared_widgets.Image(
                properties: componentProperties.properties,
                size: componentProperties.size,
                theme: theme));
        break;
    }
    return WidgetDecorator(
        onTap: () => {},
        position: componentProperties.position,
        widget: shared_widgets.Image(
            properties: componentProperties.properties,
            size: componentProperties.size,
            theme: theme));
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: position.dx,
        top: position.dy,
        child: GestureDetector(onTap: onTap, child: this.widget));
  }
}
