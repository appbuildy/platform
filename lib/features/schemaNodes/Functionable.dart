import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/ApiCallAction.dart';
import 'package:flutter_app/features/schemaNodes/GoBackAction.dart';
import 'package:flutter_app/features/schemaNodes/GoToScreenAction.dart';
import 'package:flutter_app/features/schemaNodes/OpenLinkAction.dart';

enum SchemaActionType {
  doNothing,
  goToScreen,
  goBack,
  openLink,
  apiCall,
}

abstract class Functionable {
  SchemaActionType type;
  String column;
  Function toFunction(
    UserActions userActions,
  );

  Widget toEditProps(UserActions userActions);
}

dynamic getActionByType(SchemaActionType type, dynamic value) {
  dynamic action;

  if (type == SchemaActionType.goToScreen) {
    action = GoToScreenAction('Tap', value);
  } else if (type == SchemaActionType.openLink) {
    action = OpenLinkAction('Tap', value);
  } else if (type == SchemaActionType.goBack) {
    action = GoBackAction('Tap', value);
  } else if (type == SchemaActionType.apiCall) {
    action = ApiCallAction('Tap', value);
  }

  return action;
}
