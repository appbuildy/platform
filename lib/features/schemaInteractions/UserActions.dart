import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/schemaInteractions/BaseAction.dart';
import 'package:flutter_app/features/schemaInteractions/ChangeNodeProperty.dart';
import 'package:flutter_app/features/schemaInteractions/PlaceWidget.dart';
import 'package:flutter_app/features/schemaInteractions/SelectNodeForPropsEdit.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/store/userActions/ActionsDone.dart';
import 'package:flutter_app/store/userActions/ActionsUndone.dart';
import 'package:flutter_app/store/userActions/CurrentEditingElement.dart';
import 'package:flutter_app/store/userActions/CurrentScreen.dart';

class UserActions {
  ActionsDone _actionsDone;
  ActionsUndone _actionsUndone;
  CurrentEditingNode _currentNode;
  CurrentScreen _currentScreen;

  UserActions({CurrentScreen currentScreen}) {
    _actionsDone = new ActionsDone(actions: []);
    _actionsUndone = new ActionsUndone(actions: []);
    _currentNode = CurrentEditingNode();
    _currentScreen = currentScreen;
  }

  void undo() {
    if (lastAction() == null) return;

    final removedAction = _actionsDone.actions.removeLast();
    removedAction.undo();
    _actionsUndone.add((removedAction));
  }

  void changePropertyTo(SchemaNodeProperty prop) {
    final action = ChangeNodeProperty(
        selectNodeForEdit: selectNodeForEdit,
        schemaStore: _currentScreen.currentScreen,
        node: selectedNode(),
        setProperty: prop);

    action.execute();
    _actionsDone.add(action);
  }

  void selectNodeForEdit(SchemaNode node) {
    SelectNodeForPropsEdit(node, _currentNode).execute();
  }

  void placeWidget(SchemaNode schemaNode, @required Offset position) {
    final action = new PlaceWidget(
        widget: schemaNode,
        schemaStore: _currentScreen.currentScreen,
        position: position,
        selectNodeForEdit: selectNodeForEdit);

    action.execute();
    _actionsDone.add(action);
  }

  SchemaNode selectedNode() {
    return _currentNode.selectedNode;
  }

  BaseAction lastAction() {
    // ignore: unnecessary_statements
    return _actionsDone.actions.last;
  }
}
