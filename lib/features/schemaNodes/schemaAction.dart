import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/Functionable.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';

class GoToScreenAction extends SchemaNodeProperty<String>
    implements Functionable {
  GoToScreenAction(String name, String value) : super(name, value) {
    this.type = SchemaActionType.goToScreen;
  }

  Function toFunction(UserActions userActions) {
    return () => userActions.screens.selectByName(this.value);
  }

  @override
  GoToScreenAction copy() {
    return GoToScreenAction(this.name, value);
  }

  @override
  SchemaActionType type;
}

class MyDoNothingAction extends SchemaNodeProperty implements Functionable {
  MyDoNothingAction() : super('', 'myDoNothingAction') {
    this.type = SchemaActionType.doNothing;
  }

  Function toFunction(UserActions userActions) {
    return () {};
  }

  @override
  SchemaNodeProperty copy() {
    // TODO: implement copy
    throw UnimplementedError();
  }

  @override
  SchemaActionType type;
}
