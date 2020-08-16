import 'package:flutter_app/features/canvas/SchemaNode.dart';
import 'package:flutter_app/features/schemaInteractions/BaseAction.dart';
import 'package:flutter_app/features/schemaInteractions/PlaceWidget.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_app/store/userActions/ActionsDone.dart';

class UserActions {
  ActionsDone _actionsDone;

  UserActions() {
    _actionsDone = new ActionsDone(actions: []);
  }

  void undo() {
    if (lastAction() == null) return;

    lastAction().undo();
    // TODO: Move to redostack
  }

  void placeWidget(SchemaNode schemaNode, SchemaStore schemaStore) {
    final action =
        new PlaceWidget(widget: schemaNode, schemaStore: schemaStore);

    action.execute();
    _actionsDone.add(action);
  }

  BaseAction lastAction() {
    // ignore: unnecessary_statements
    return _actionsDone.actions.last;
  }
}
