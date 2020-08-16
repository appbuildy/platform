import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum SchemaNodeType { button, text }

abstract class SchemaNode {
  SchemaNodeType type;
  Offset position;

  SchemaNode({Offset position}) {
    this.position = position;
  }

  Widget toWidget();
}

class SchemaNodeButton extends SchemaNode {
  SchemaNodeButton({Offset position}) {
    type = SchemaNodeType.button;
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
