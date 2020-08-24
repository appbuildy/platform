import 'package:flutter_app/features/schemaInteractions/BaseAction.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';

class DeleteNode extends BaseAction {
  SchemaNode _node;
  SchemaStore _schemaStore;
  Function _selectNodeForEdit;

  DeleteNode(
      {SchemaNode node, SchemaStore schemaStore, Function selectNodeForEdit}) {
    this._node = node;
    _schemaStore = schemaStore;
    _selectNodeForEdit = selectNodeForEdit ?? (_arg) {};
  }

  @override
  void execute() {
    executed = true;
    _schemaStore.remove(_node);
    _selectNodeForEdit(null);
  }

  @override
  void redo() {
    // TODO: implement redo
  }

  @override
  void undo() {
    if (!executed) return;
    _schemaStore.add(_node);
    _selectNodeForEdit(_node);
  }
}
