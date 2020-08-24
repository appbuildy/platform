import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/BaseAction.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';

class CopyNode extends BaseAction {
  SchemaNode _node;
  SchemaStore _schemaStore;
  Function _selectNodeForEdit;
  SchemaNode newNode;

  CopyNode(
      {SchemaNode node, SchemaStore schemaStore, Function selectNodeForEdit}) {
    this._node = node;
    _schemaStore = schemaStore;
    _selectNodeForEdit = selectNodeForEdit ?? (_arg) {};
  }

  @override
  void execute() {
    executed = true;
    newNode = _node.copy(
      id: UniqueKey(),
      saveProperties: false,
    );
    _schemaStore.add(newNode);
    _selectNodeForEdit(newNode);
  }

  @override
  void redo() {
    // TODO: implement redo
  }

  @override
  void undo() {
    if (!executed) return;
    _schemaStore.remove(newNode);
    _selectNodeForEdit(null);
  }
}
