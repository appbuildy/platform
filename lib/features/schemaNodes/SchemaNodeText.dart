import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/ui/MyTextField.dart';

class SchemaNodeText extends SchemaNode {
  SchemaNodeText({Offset position}) : super(position: position) {
    this.type = SchemaNodeType.button;
    this.properties = {'Text': SchemaStringProperty('Text', 'Text')};
  }

  @override
  SchemaNode copy({Offset position}) {
    return SchemaNodeText(position: position);
  }

  @override
  Widget toWidget() {
    return Text(
      properties['Text'].value,
      style: TextStyle(fontSize: 16.0),
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
    ]);
  }
}
