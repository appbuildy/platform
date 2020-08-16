import 'package:flutter_app/features/canvas/SchemaNode.dart';
import 'package:flutter_app/features/schemaInteractions/BaseAction.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';

class PlaceWidget extends BaseAction {
  SchemaNode _widget;
  SchemaStore _schemaStore;

  PlaceWidget({ToolboxSchemaNode widget, SchemaStore schemaStore}) {
    _widget = widget;
    _schemaStore = schemaStore;
  }

  @override
  void execute() {
    executed = true;
    _schemaStore.add(_toolboxWidget.produceAppPreviewWidget());
  }

  @override
  void redo() {
    // TODO: implement redo
  }

  @override
  void undo() {
    if (!executed) return;
    _schemaStore.remove(_widget);
  }
}
