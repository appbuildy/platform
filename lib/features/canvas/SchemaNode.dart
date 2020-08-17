import 'package:flutter/material.dart';
import 'package:flutter_app/features/canvas/SchemaNodeProperty.dart';

enum SchemaNodeType { button, text, shape }

abstract class SchemaNode {
  UniqueKey id;
  SchemaNodeType type;
  Offset position;
  Map<String, SchemaNodeProperty> properties;

  SchemaNode({
    Offset position,
  }) {
    this.position = position;
    this.id = UniqueKey();
  }

  SchemaNode copy({Offset position});
  Widget toWidget();
  Widget toPropsEdit();
}

class SchemaNodeText implements SchemaNode {
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
  Widget toPropsEdit() {
    return TextField(
      onChanged: (newText) {
        properties['Text'] = SchemaStringProperty('Text', newText);
      },
    );
  }
}

class SchemaNodeShape extends SchemaNode {
  SchemaNodeShape({Offset position}) : super(position: position) {
    this.type = SchemaNodeType.button;
    this.properties = {
      'Color': SchemaColorProperty('Color', Colors.red),
    };
  }

  @override
  SchemaNode copy({Offset position}) {
    return SchemaNodeShape(position: position);
  }

  @override
  Widget toWidget() {
    return Container(
      width: 35,
      height: 35,
      color: Colors.white,
    );
  }

  @override
  Widget toPropsEdit() {
    return Text(
      'Text',
      style: TextStyle(fontSize: 16.0),
    );
  }
}

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
  Widget toPropsEdit() {
    return TextField(
      onChanged: (newText) {
        properties['Text'] = SchemaStringProperty('Text', newText);
      },
    );
  }
}
