import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/schemaInteractions/BaseAction.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';

class PlaceWidget extends BaseAction {
  SchemaNode _widget;
  SchemaStore _schemaStore;
  Offset _position;
  SchemaNode _newWidget;

  PlaceWidget({SchemaNode widget, SchemaStore schemaStore, Offset position}) {
    _widget = widget;
    _schemaStore = schemaStore;
    _position = position;
  }

  @override
  void execute() {
    executed = true;
    _newWidget = _widget.copy(position: _position);
    _schemaStore.add(_newWidget);
  }

  @override
  void redo() {
    // TODO: implement redo
  }

  @override
  void undo() {
    if (!executed) return;
    _schemaStore.remove(_newWidget);
  }
}
