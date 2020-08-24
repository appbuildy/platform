import 'package:flutter_app/features/schemaInteractions/UserActions.dart';

enum SchemaActionType { goToScreen }

abstract class SchemaAction {
  SchemaActionType type;
  String value;
  SchemaAction(this.value);

  Function toFunction(UserActions userActions);
}

class GoToScreenAction extends SchemaAction {
  GoToScreenAction(String value) : super(value) {
    this.type = SchemaActionType.goToScreen;
  }

  Function toFunction(UserActions userActions) {
    return () => userActions.screens.selectByName(this.value);
  }
}
