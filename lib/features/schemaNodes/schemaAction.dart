import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/ChangeableProperty.dart';

enum SchemaActionType { doNothing, goToScreen }

abstract class SchemaAction implements ChangeableProperty<String> {
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

class MyDoNothingAction extends SchemaAction {
  MyDoNothingAction() : super('myDoNothingAction') {
    this.type = SchemaActionType.doNothing;
  }

  Function toFunction(UserActions userActions) {
    return () {};
  }
}
