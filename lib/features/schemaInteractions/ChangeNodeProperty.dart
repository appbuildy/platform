import 'dart:developer';

import 'package:flutter_app/features/schemaInteractions/BaseAction.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';

class ChangeNodeProperty extends BaseAction {
  SchemaNodeProperty property;
  SchemaNode node;
  SchemaStore schemaStore;
  var oldValue;

  ChangeNodeProperty(
      {SchemaStore schemaStore,
      SchemaNode node,
      SchemaNodeProperty setProperty}) {
    this.property = setProperty;
    this.schemaStore = schemaStore;
    this.node = node;
    this.oldValue = setProperty.value;
  }

  @override
  void execute() {
    oldValue = node.properties[property.name].value;
    if (oldValue == null) return;
    executed = true;
    log('Change prop called ${property.value}');
    node.properties[property.name].value = property.value;
    schemaStore.update(node);
  }

  @override
  void redo() {
    // TODO: implement redo
  }

  @override
  void undo() {
    if (!executed) return;
    log('UNDO Change prop called ${oldValue}');
    node.properties[property.name].value = oldValue;
    schemaStore.update(node);
  }
}
