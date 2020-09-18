import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/Functionable.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';

import 'JsonConvertable.dart';

class GoToScreenAction extends SchemaNodeProperty<UniqueKey>
    implements Functionable, JsonConvertable {
  GoToScreenAction(String name, UniqueKey value) : super(name, value) {
    this.type = SchemaActionType.goToScreen;
    this.name = name;
    this.value = value;
  }

  Function toFunction(UserActions userActions) {
    return () => userActions.screens.selectById(this.value);
  }

  @override
  GoToScreenAction copy() {
    return GoToScreenAction(this.name, value);
  }

  @override
  SchemaActionType type;

  @override
  Map<String, dynamic> toJson() {
    return {
      'action': this.name,
      'type': this.type.toString(),
      'value': this.value
    };
  }
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
    return MyDoNothingAction();
  }

  @override
  SchemaActionType type;
}
