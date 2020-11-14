import 'package:flutter/cupertino.dart';
import 'package:flutter_app/serialization/component_properties.dart';

class WidgetDecorator extends StatelessWidget {
  const WidgetDecorator({Key key, this.onTap, this.widget, this.position})
      : super(key: key);

  final Widget widget;
  final Offset position;
  final Function onTap;

  factory WidgetDecorator.fromJson(Map<String, dynamic> jsonComponent) {
    var componentProperties = ComponentProperties(jsonComponent);

    switch (jsonComponent['type']) {
      case 'SchemaNodeType.button':
        {}
        break;
      case 'SchemaNodeType.text':
        {}
        break;

      case 'SchemaNodeType.shape':
        {}
        break;

      case 'SchemaNodeType.icon':
        {}
        break;

      case 'SchemaNodeType.list':
        {}
        break;
      case 'SchemaNodeType.image':
        {}
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: position.dx,
        top: position.dy,
        child: GestureDetector(onTap: onTap, child: this.widget));
  }
}
