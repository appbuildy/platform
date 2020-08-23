import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/schemaInteractions/BaseAction.dart';
import 'package:flutter_app/features/schemaInteractions/ChangeNodeProperty.dart';
import 'package:flutter_app/features/schemaInteractions/PlaceWidget.dart';
import 'package:flutter_app/features/schemaInteractions/RepositionAndResize.dart';
import 'package:flutter_app/features/schemaInteractions/Screens.dart';
import 'package:flutter_app/features/schemaInteractions/SelectNodeForPropsEdit.dart';
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

  void undo() {
    if (lastAction() == null) return;

    final removedAction = _actionsDone.actions.removeLast();
    removedAction.undo();
    _actionsUndone.add((removedAction));
  }

  void changePropertyTo(SchemaNodeProperty prop,
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

  void repositionAndResize(SchemaNode updatedNode,
      [bool isAddedToDoneActions = true, SchemaNode prevValue]) {
    final action =
        RepositionAndResize(schemaStore: currentScreen, node: updatedNode);

    action.execute(prevValue);
    if (isAddedToDoneActions) {
      _actionsDone.add(action);
    }
  }

  void selectNodeForEdit(SchemaNode node) {
    SelectNodeForPropsEdit(node, _currentNode).execute();
  }

  SchemaNode placeWidget(SchemaNode schemaNode, Offset position) {
    final action = new PlaceWidget(
        node: schemaNode,
        schemaStore: currentScreen,
        position: position,
        selectNodeForEdit: selectNodeForEdit);

    action.execute();
    _actionsDone.add(action);

    return action.newNode;
  }

  SchemaNode selectedNode() {
    return _currentNode.selectedNode;
  }

  BaseAction lastAction() {
    // ignore: unnecessary_statements
    return _actionsDone.actions.last;
  }
}
