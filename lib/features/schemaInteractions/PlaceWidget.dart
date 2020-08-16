import 'package:flutter_app/features/canvas/SchemaNode.dart';
import 'package:flutter_app/features/schemaInteractions/BaseAction.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';

class PlaceWidget extends BaseAction {
  SchemaNode _widget;
  SchemaStore _schemaStore;

  PlaceWidget({SchemaNode widget, SchemaStore schemaStore}) {
    _widget = widget;
    _schemaStore = schemaStore;
  }

  @override
  void execute() {
    _schemaStore.add(_widget);
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
