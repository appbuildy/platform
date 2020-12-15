import 'package:flutter/cupertino.dart';
import 'package:flutter_app/serialization/component_properties.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';

import 'shared_widgets.dart';

class WidgetDecorator extends StatelessWidget {
  const WidgetDecorator({
    Key key,
    this.position,
    this.size,
    this.child,
    this.onTap,
  }) : super(key: key);

  final Widget child;
  final Offset position;
  final Offset size;
  final VoidCallback onTap;

  factory WidgetDecorator.fromJson(Map<String, dynamic> jsonComponent) {
    var theme = MyThemes.allThemes['blue'];
    var componentProperties = ComponentProperties(jsonComponent);
    var previewActions = componentProperties.previewActions;

    switch (jsonComponent['type']) {
      case 'SchemaNodeType.button':
        {
          return WidgetDecorator(
            onTap: previewActions['Tap'].functionAction,
            position: componentProperties.position,
            child: SharedButton(
              properties: componentProperties.properties,
              theme: theme,
            ),
          );
        }
        break;
      case 'SchemaNodeType.text':
        {
          return WidgetDecorator(
            position: componentProperties.position,
            child: SharedText(
                properties: componentProperties.properties,
                size: componentProperties.size,
                theme: theme),
          );
        }
        break;

      case 'SchemaNodeType.shape':
        {
          return WidgetDecorator(
            position: componentProperties.position,
            child: SharedShape(
              properties: componentProperties.properties,
              size: componentProperties.size,
              theme: theme,
            ),
          );
        }
        break;

      case 'SchemaNodeType.icon':
        {
          return WidgetDecorator(
            position: componentProperties.position,
            child: SharedIcon(
              properties: componentProperties.properties,
              theme: theme,
            ),
          );
        }
        break;

      case 'SchemaNodeType.list':
        {
          return WidgetDecorator(
            position: componentProperties.position,
            child: SharedButton(
              properties: componentProperties.properties,
              theme: theme,
            ),
          );
        }
        break;
      case 'SchemaNodeType.image':
      default:
        return WidgetDecorator(
          position: componentProperties.position,
          child: SharedImage(
            properties: componentProperties.properties,
            size: componentProperties.size,
            theme: theme,
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      height: size.dx,
      width: size.dy,
      child: GestureDetector(
        onTap: onTap,
        child: this.child,
      ),
    );
  }
}
