import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';

class SchemaNodeButton extends SchemaNode {
  SchemaNodeButton({Offset position}) : super(position: position) {
    this.type = SchemaNodeType.button;
    this.properties = {
      'Text': SchemaStringProperty('Text', 'Button'),
      'Background': SchemaColorProperty('Background', Colors.indigo)
    };
  }

  @override
  SchemaNode copy({Offset position}) {
    return SchemaNodeButton(position: position);
  }

  @override
  Widget toWidget() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: Colors.tealAccent)),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Text(properties['Text'].value),
      ),
    );
  }

  @override
  Widget toEditProps(changePropTo) {
    return Container(
      child: TextField(
        onChanged: (newText) {
          changePropTo(SchemaStringProperty('Text', newText));
        },
      ),
    );
  }
}
