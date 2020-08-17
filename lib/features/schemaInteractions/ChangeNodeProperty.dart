import 'package:flutter_app/features/canvas/SchemaNode.dart';
import 'package:flutter_app/features/canvas/SchemaNodeProperty.dart';
import 'package:flutter_app/features/schemaInteractions/BaseAction.dart';

class ChangeNodeProperty extends BaseAction {
  SchemaNodeProperty property;
  SchemaNode node;
  SchemaNodeProperty oldProperty;

  ChangeNodeProperty({SchemaNode node, SchemaNodeProperty setProperty}) {
    this.property = setProperty;
    this.node = node;
  }

  @override
  void execute() {
    oldProperty = node.properties[property.name];
    if (oldProperty == null) return;
    node.properties[property.name] = property;
  }

  @override
  void redo() {
    // TODO: implement redo
  }

  @override
  void undo() {
    // TODO: implement undo
  }
}
