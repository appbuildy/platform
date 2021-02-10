import 'package:flutter_app/features/schemaInteractions/BaseAction.dart';
import 'package:flutter_app/features/schemaNodes/ChangeableProperty.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';

enum ChangeAction { properties, actions }

class ChangeNodeProperty extends BaseAction {
  SchemaNodeProperty property;
  Function selectNodeForEdit;
  SchemaNode node;
  SchemaStore schemaStore;
  dynamic oldValue;
  ChangeAction changeAction;

  ChangeNodeProperty(
      {SchemaStore schemaStore,
      SchemaNode node,
      ChangeAction changeAction = ChangeAction.properties,
      ChangeableProperty newProp,
      Function selectNodeForEdit}) {
    this.property = newProp;
    this.schemaStore = schemaStore;
    this.node = node;
    this.oldValue = newProp.value;
    this.changeAction = changeAction;
    this.selectNodeForEdit = selectNodeForEdit ?? (_n, _b) => {};
  }

  @override
  void execute([String prevValue]) {
    final propsOrActions = changeAction == ChangeAction.properties
        ? node.properties
        : node.actions;

    if (prevValue != null) {
      oldValue = prevValue;
    } else {
      oldValue = propsOrActions[property.name].value;
    }

//    if (oldValue == null) return;
    executed = true;
    if (changeAction == ChangeAction.properties) {
      propsOrActions[property.name].value = property.value;
    } else {
      // в наших экшенах не только валю меняется, а еще тип и тд потому что они Functionable
      propsOrActions[property.name] = property;
    }
    selectNodeForEdit(
        node, true); // reselect node to updates be applied on the right bar
    schemaStore.update(node);
  }

  @override
  void redo() {
    // TODO: implement redo
  }

  @override
  void undo() {
    if (!executed) return;
    if (changeAction == ChangeAction.properties) {
      node.properties[property.name].value = oldValue;
    } else {
      node.properties[property.name] = oldValue;
    }
    node.properties[property.name].value = oldValue;
    selectNodeForEdit(node, false);
    schemaStore.update(node);
  }
}
