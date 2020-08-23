import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/schemaInteractions/BaseAction.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';

class PlaceWidget extends BaseAction {
  SchemaNode _node;
  SchemaStore _schemaStore;
  Offset _position;
  SchemaNode newNode;
  Function _selectNodeForEdit;

  PlaceWidget(
      {SchemaNode node,
      SchemaStore schemaStore,
      Offset position,
      Function selectNodeForEdit}) {
    this._node = node;
    _schemaStore = schemaStore;
    _position = position;
    _selectNodeForEdit = selectNodeForEdit ?? (_arg) {};
  }

  @override
  void execute() {
    executed = true;
    newNode = _node.copy(position: _position, id: UniqueKey());
    _schemaStore.add(newNode);
    _selectNodeForEdit(newNode);
  }

  @override
  void redo() {
    // TODO: implement redo
  }

  @override
  void undo() {
    log('new Node ${newNode.id}');

    if (!executed) return;
    _schemaStore.remove(newNode);
    _selectNodeForEdit(null);
  }
}
