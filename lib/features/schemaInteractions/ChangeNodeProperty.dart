import 'package:flutter_app/features/canvas/SchemaNodeProperty.dart';
import 'package:flutter_app/features/schemaInteractions/BaseAction.dart';

class ChangeNodeProperty extends BaseAction {
  SchemaNodeProperty property;

  ChangeNodeProperty(SchemaNodeProperty property) {
    property = property;
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
