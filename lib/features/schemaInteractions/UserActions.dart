import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/schemaInteractions/BaseAction.dart';
import 'package:flutter_app/features/schemaInteractions/ChangeNodeProperty.dart';
import 'package:flutter_app/features/schemaInteractions/CopyNode.dart';
import 'package:flutter_app/features/schemaInteractions/DeleteNode.dart';
import 'package:flutter_app/features/schemaInteractions/PlaceWidget.dart';
import 'package:flutter_app/features/schemaInteractions/RepositionAndResize.dart';
import 'package:flutter_app/features/schemaInteractions/Screens.dart';
import 'package:flutter_app/features/schemaInteractions/SelectNodeForPropsEdit.dart';
import 'package:flutter_app/features/schemaNodes/ChangeableProperty.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_app/store/userActions/ActionsDone.dart';
import 'package:flutter_app/store/userActions/ActionsUndone.dart';
import 'package:flutter_app/store/userActions/CurrentEditingElement.dart';

class UserActions {
  ActionsDone _actionsDone;
  ActionsUndone _actionsUndone;
  CurrentEditingNode _currentNode;
  Screens _screens;

  UserActions({Screens screens}) {
    _actionsDone = new ActionsDone(actions: []);
    _actionsUndone = new ActionsUndone(actions: []);
    _currentNode = CurrentEditingNode();
    _screens = screens;
  }

  SchemaStore get currentScreen => _screens.current;
  Screens get screens => _screens;

  void changeActionTo(ChangeableProperty prop,
      [bool isAddedToDoneActions = true, prevValue]) {
    final action = ChangeNodeProperty(
        selectNodeForEdit: selectNodeForEdit,
        schemaStore: currentScreen,
        changeAction: ChangeAction.actions,
        node: selectedNode(),
        newProp: prop);

    action.execute(prevValue);
    if (isAddedToDoneActions) {
      _actionsDone.add(action);
    }
  }

  void changePropertyTo(ChangeableProperty prop,
      [bool isAddedToDoneActions = true, prevValue]) {
    final action = ChangeNodeProperty(
        selectNodeForEdit: selectNodeForEdit,
        schemaStore: currentScreen,
        node: selectedNode(),
        newProp: prop);

    action.execute(prevValue);
    if (isAddedToDoneActions) {
      _actionsDone.add(action);
    }
  }

  void copyNode(
    SchemaNode node,
  ) {
    final action = new CopyNode(
        node: node,
        schemaStore: currentScreen,
        selectNodeForEdit: selectNodeForEdit);

    action.execute();
    _actionsDone.add(action);
  }

  void deleteNode(
    SchemaNode node,
  ) {
    final action = new DeleteNode(
        node: node,
        schemaStore: currentScreen,
        selectNodeForEdit: selectNodeForEdit);

    action.execute();
    _actionsDone.add(action);
  }

  BaseAction lastAction() {
    // ignore: unnecessary_statements
    return _actionsDone.actions.last;
  }

  SchemaNode placeWidget(SchemaNode node, Offset position) {
    final action = new PlaceWidget(
        node: node,
        schemaStore: currentScreen,
        position: position,
        selectNodeForEdit: selectNodeForEdit);

    action.execute();
    _actionsDone.add(action);

    return action.newNode;
  }

  void repositionAndResize(SchemaNode updatedNode,
      [bool isAddedToDoneActions = true, SchemaNode prevValue]) {
    final action =
        RepositionAndResize(schemaStore: currentScreen, node: updatedNode);

    action.execute(prevValue);
    if (isAddedToDoneActions) {
      _actionsDone.add(action);
    }
  }

  SchemaNode selectedNode() {
    return _currentNode.selectedNode;
  }

  void selectNodeForEdit(SchemaNode node) {
    SelectNodeForPropsEdit(node, _currentNode).execute();
  }

  void undo() {
    if (lastAction() == null) return;

    final removedAction = _actionsDone.actions.removeLast();
    removedAction.undo();
    _actionsUndone.add((removedAction));
  }
}
