import 'package:flutter_app/features/schemaInteractions/BaseAction.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_app/features/schemaNodes/ChangeableProperty.dart';

class ChangeNodeProperty extends BaseAction {
  SchemaNodeProperty property;
  Function selectNodeForEdit;
  SchemaNode node;
  SchemaStore schemaStore;
  String oldValue;

  ChangeNodeProperty(
      {SchemaStore schemaStore,
      SchemaNode node,
      ChangeableProperty newProp,
      Function selectNodeForEdit}) {
    this.property = newProp;
    this.schemaStore = schemaStore;
    this.node = node;
    this.oldValue = newProp.value;
    this.selectNodeForEdit = selectNodeForEdit;
  }

  @override
  void execute([String prevValue]) {
    if (prevValue != null) {
      oldValue = prevValue;
    } else {
      oldValue = node.properties[property.name].value;
    }

    if (oldValue == null) return;
    executed = true;
    node.properties[property.name].value = property.value;
    selectNodeForEdit(
        node); // reselect node to updates be applied on the right bar
    schemaStore.update(node);
  }

  @override
  void redo() {
    // TODO: implement redo
  }

  @override
  void undo() {
    if (!executed) return;
    node.properties[property.name].value = oldValue;
    selectNodeForEdit(node);
    schemaStore.update(node);
  }
}
