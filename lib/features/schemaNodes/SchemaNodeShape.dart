import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';

class SchemaNodeShape extends SchemaNode {
  SchemaNodeShape(
      {Offset position,
      Offset size,
      Map<String, SchemaNodeProperty> properties,
      UniqueKey id})
      : super() {
    this.type = SchemaNodeType.shape;
    this.position = position ?? Offset(0, 0);
    this.size = size ?? Offset(150.0, 100.0);
    this.id = id ?? UniqueKey();
    this.properties =
        properties ?? {'Color': SchemaColorProperty('Color', Colors.red)};
  }

  @override
  SchemaNode copy(
      {Offset position,
      Offset size,
      UniqueKey id,
      bool saveProperties = true}) {
    return SchemaNodeShape(position: position);
  }

  @override
  Widget toWidget() {
    return Container(
      width: size.dx,
      height: size.dy,
      color: properties['Color'].value,
    );
  }

  @override
  Widget toEditProps(userActions) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            userActions
                .changePropertyTo(SchemaColorProperty('Color', Colors.black));
          },
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(color: Colors.black),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        GestureDetector(
          onTap: () {
            userActions
                .changePropertyTo(SchemaColorProperty('Color', Colors.red));
          },
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(color: Colors.red),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        GestureDetector(
          onTap: () {
            userActions
                .changePropertyTo(SchemaColorProperty('Color', Colors.blue));
          },
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(color: Colors.blue),
          ),
        ),
        SizedBox(
          width: 8,
        ),
      ],
    );
  }
}
