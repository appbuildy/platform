import 'package:flutter/material.dart';
import 'package:flutter_app/features/canvas/SchemaNodeProperty.dart';

enum SchemaNodeType { button, text }

abstract class SchemaNode {
  UniqueKey id;
  SchemaNodeType type;
  Offset position;
  List<SchemaNodeProperty> properties;

  SchemaNode({
    Offset position,
  }) {
    this.position = position;
    this.id = UniqueKey();
  }

  SchemaNode copy({Offset position});
  Widget toWidget();
}

class SchemaNodeButton extends SchemaNode {
  SchemaNodeButton({Offset position}) : super(position: position) {
    this.type = SchemaNodeType.button;
    this.properties = [
      SchemaSimpleProperty('Text', 'Button'),
      SchemaSimpleProperty('Background', Colors.indigo.toString())
    ];
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
        child: Text('Button'),
      ),
    );
  }
}
