import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/GoToScreenAction.dart';

enum SchemaActionType {
  doNothing,
  goToScreen,
  openLink,
  apiCall,
}

abstract class Functionable {
  SchemaActionType type;
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
    action = GoToScreenAction('Tap', value);
  } else if (type == SchemaActionType.apiCall) {
    action = GoToScreenAction('Tap', value);
  }

  return action;
}
