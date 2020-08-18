import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';

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

  SchemaNode({
    Offset position,
  }) {
    this.position = position;
    this.id = UniqueKey();
  }

  SchemaNode copy({Offset position});
  Widget toWidget();
  Widget toEditProps(Function changePropertyTo);
}
