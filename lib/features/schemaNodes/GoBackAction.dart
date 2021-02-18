import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/Functionable.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/utils/RandomKey.dart';

import 'lists/ListItem.dart';

class GoBackAction extends SchemaNodeProperty<RandomKey>
    implements Functionable {
  GoBackAction(String name, RandomKey value) : super(name, value) {
    this.type = SchemaActionType.goBack;
    this.name = name;
    this.value = value;
    this.column = null;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'propertyClass': 'GoBackAction',
      'action': this.name,
      'type': this.type.toString(),
      'value': this.value == null ? null : this.value.toJson(),
      'column': this.column,
    };
  }

  GoBackAction.fromJson(Map<String, dynamic> jsonVal) : super('Prop', null) {
    this.name = jsonVal['action'];
    this.type = SchemaActionType.goBack;
    this.value = RandomKey.fromJson(jsonVal['value']);
    this.column = jsonVal['column'];
  }

  Function toFunction(UserActions userActions) {
    return ([Map<String, ListItem> rowData]) {
      userActions.screens.selectById(this.value);
    };
  }

  @override
  GoBackAction copy() {
    return GoBackAction(this.name, value);
  }

  @override
  SchemaActionType type;

  @override
  String column;

  @override
  Widget toEditProps(UserActions userActions) {
    return Container();
  }
}
