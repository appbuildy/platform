import 'package:flutter_app/features/canvas/SchemaNode.dart';
import 'package:flutter_app/features/canvas/SchemaNodeProperty.dart';
import 'package:flutter_app/features/schemaInteractions/BaseAction.dart';

class ChangeNodeProperty extends BaseAction {
  SchemaNodeProperty property;
  SchemaNode node;

  ChangeNodeProperty({SchemaNode node, SchemaNodeProperty setProperty}) {
    property = property;
    node = node;
  }

  @override
  void execute() {
    // TODO: implement execute
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
