import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/schemaAction.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_app/ui/ScreensSelect.dart';
import 'package:mobx/mobx.dart';

class AllActions extends StatelessWidget {
  final ObservableList<SchemaStore> screens;
  final UserActions userActions;

  const AllActions(
      {Key key, @required this.userActions, @required this.screens})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    log('length screens ${screens.length}');
    return ScreensSelect(
        userActions: userActions,
        action: GoToScreenAction('Tap', 'Main'),
        screens: screens);
  }
}
