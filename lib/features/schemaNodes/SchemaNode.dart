import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/features/schemaNodes/schemaAction.dart';

export 'SchemaNodeButton.dart';
export 'SchemaNodeProperty.dart';
export 'SchemaNodeShape.dart';
export 'SchemaNodeText.dart';

enum SchemaNodeType { button, text, shape }

abstract class SchemaNode {
  UniqueKey id;
  SchemaNodeType type;
  Offset position;
  Offset size;
  Map<String, SchemaNodeProperty> properties;
  Map<String, SchemaAction> actions;

  SchemaNode copy({
    Offset position,
    Offset size,
    UniqueKey id,
    bool saveProperties,
  });

  Map<String, dynamic> toJson() => {
        'position': {'x': position.dx, 'y': position.dy},
        'size': {'x': size.dx, 'y': size.dy},
        'type': SchemaNodeType.button
      };
  Widget toWidget();
  Widget toEditProps(Function changePropertyTo);
}
