import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';

class SchemaNodeShape extends SchemaNode {
  SchemaNodeShape({Offset position}) : super(position: position) {
    this.type = SchemaNodeType.button;
    this.properties = {};
  }

  @override
  SchemaNode copy({Offset position}) {
    return SchemaNodeShape(position: position);
  }

  @override
  Widget toWidget() {
    return Container(
      width: 30,
      height: 30,
    );
  }

  @override
  Widget toEditProps(changePropTo) {
    return Container(
      color: Colors.red,
      width: 20,
      height: 20,
    );
  }
}
