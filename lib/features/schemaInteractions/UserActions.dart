import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/canvas/SchemaNode.dart';
import 'package:flutter_app/features/schemaInteractions/BaseAction.dart';
import 'package:flutter_app/features/schemaInteractions/PlaceWidget.dart';
import 'package:flutter_app/features/schemaInteractions/SelectNodeForPropsEdit.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_app/store/userActions/ActionsDone.dart';
import 'package:flutter_app/store/userActions/ActionsUndone.dart';
import 'package:flutter_app/store/userActions/CurrentEditingElement.dart';

class UserActions {
  ActionsDone _actionsDone;
  ActionsUndone _actionsUndone;

  UserActions() {
    _actionsDone = new ActionsDone(actions: []);
    _actionsUndone = new ActionsUndone(actions: []);
  }

  void undo() {
    if (lastAction() == null) return;

    final removedAction = _actionsDone.actions.removeLast();
    removedAction.undo();
    _actionsUndone.add((removedAction));
  }

  void selectNodeForEdit(
      SchemaNode node, CurrentEditingElement currentElement) {
    SelectNodeForPropsEdit(node, currentElement).execute();
  }

  void placeWidget(SchemaNode schemaNode, SchemaStore schemaStore,
      @required Offset position) {
    final action = new PlaceWidget(
        widget: schemaNode, schemaStore: schemaStore, position: position);

    action.execute();
    _actionsDone.add(action);
  }

  BaseAction lastAction() {
    // ignore: unnecessary_statements
    return _actionsDone.actions.last;
  }
}
