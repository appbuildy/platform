import 'dart:developer';

import 'package:flutter_app/features/schemaInteractions/BaseAction.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';

class ChangeNodeProperty extends BaseAction {
  SchemaNodeProperty property;
  SchemaNode node;
  SchemaNodeProperty oldProperty;
  SchemaStore schemaStore;

  ChangeNodeProperty(
      {SchemaStore schemaStore,
      SchemaNode node,
      SchemaNodeProperty setProperty}) {
    this.property = setProperty;
    this.schemaStore = schemaStore;
    this.node = node;
  }

  @override
  void execute() {
    oldProperty = node.properties[property.name];
    if (oldProperty == null) return;
    executed = true;

    log('Change prop called ${property.value}');

    node.properties[property.name] = property;
    schemaStore.update(node);
  }

  @override
  void redo() {
    // TODO: implement redo
  }

  @override
  void undo() {
    if (!executed) return;
    node.properties[property.name] = oldProperty;
  }
}
