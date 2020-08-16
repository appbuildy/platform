import 'package:flutter/cupertino.dart';

enum SchemaNodeType { button, text }

class SchemaNode {
  SchemaNodeType type;
  Offset position;

  SchemaNode({SchemaNodeType type, Offset position}) {
    this.type = type;
    this.position = position;
  }
}
