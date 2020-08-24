import 'package:flutter_app/features/schemaInteractions/UserActions.dart';

enum SchemaActionType { goToScreen }

abstract class SchemaAction {
  SchemaActionType type;
  String value;

  Function toFunction(UserActions userActions);
}

class GoToScreenAction extends SchemaAction {
  GoToScreenAction() : super() {
    this.type = SchemaActionType.goToScreen;
  }

  Function toFunction(UserActions userActions) {
    return () => userActions.screens.selectByName(this.value);
  }
}
