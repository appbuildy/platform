import 'package:flutter_app/features/canvas/WidgetPosition.dart';

enum SchemaNodeType { button, text }

class SchemaNode {
  SchemaNodeType type;
  WidgetPosition position;

  SchemaNode({SchemaNodeType type, WidgetPosition position}) {
    this.type = type;
    this.position = position;
  }
}
