import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';

class SchemaNodeShape extends SchemaNode {
  SchemaNodeShape({Offset position}) : super(position: position) {
    this.type = SchemaNodeType.button;
    this.size = Offset(100.0, 100.0);
    this.properties = {'Color': SchemaColorProperty('Color', Colors.white)};
  }

  @override
  SchemaNode copy({Offset position}) {
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
  Widget toEditProps(changePropTo) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            changePropTo(SchemaColorProperty('Color', Colors.black));
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
            changePropTo(SchemaColorProperty('Color', Colors.red));
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
            changePropTo(SchemaColorProperty('Color', Colors.blue));
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
