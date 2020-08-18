import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/ui/MyTextField.dart';

class SchemaNodeText extends SchemaNode {
  SchemaNodeText({Offset position}) : super(position: position) {
    this.type = SchemaNodeType.button;
    this.size = Offset(100.0, 100.0);
    this.properties = {
      'Text': SchemaStringProperty('Text', 'Text'),
      'Color': SchemaColorProperty('Color', Colors.black)
    };
  }

  @override
  SchemaNode copy({Offset position}) {
    return SchemaNodeText(position: position);
  }

  @override
  Widget toWidget() {
    return Container(
      width: size.dx,
      height: size.dy,
      child: Text(
        properties['Text'].value,
        style: TextStyle(fontSize: 16.0, color: properties['Color'].value),
      ),
    );
  }

  @override
  Widget toEditProps(changePropTo) {
    return Column(children: [
      Text(
        'Text Node',
      ),
      SizedBox(height: 16),
      Text('Value'),
      SizedBox(height: 8),
      MyTextField(
        key: id,
        defaultValue: properties['Text'].value,
        onChanged: (newText) {
          changePropTo(SchemaStringProperty('Text', newText));
        },
      ),
      SizedBox(height: 8),
      Row(
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
      ),
    ]);
  }
}
