import 'package:flutter_app/features/schemaInteractions/BaseAction.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';

class ChangeNodeProperty extends BaseAction {
  SchemaNodeProperty property;
  Function selectNodeForEdit;
  SchemaNode node;
  SchemaStore schemaStore;
  var oldValue;

  ChangeNodeProperty(
      {SchemaStore schemaStore,
      SchemaNode node,
      SchemaNodeProperty setProperty,
      Function selectNodeForEdit}) {
    this.property = setProperty;
    this.schemaStore = schemaStore;
    this.node = node;
    this.oldValue = setProperty.value;
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
    selectNodeForEdit(node);
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
