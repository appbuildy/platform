import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';

import 'Functionable.dart';

class MyDoNothingAction extends SchemaNodeProperty implements Functionable {
  MyDoNothingAction(String name) : super(name, null) {
    this.type = SchemaActionType.doNothing;
    this.column = null;
  }

  Map<String, dynamic> toJson() {
    return {
      'propertyClass': 'MyDoNothingAction',
      'action': this.name,
      'type': this.type.toString(),
      'value': null,
      'column': null
    };
  }

  MyDoNothingAction.fromJson(Map<String, dynamic> jsonVal)
      : super('Prop', null) {
    this.name = jsonVal['action'];
    this.type = SchemaActionType.doNothing;
    this.value = null;
    this.column = jsonVal['column'];
  }

  Function toFunction(UserActions userActions) {
    return () {};
  }

  @override
  SchemaNodeProperty copy() {
    return MyDoNothingAction(this.name);
  }

  @override
  SchemaActionType type;

  @override
  Widget toEditProps(UserActions userActions) {
    return Container();
  }

  @override
  String column;
}
