import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/schemaAction.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:mobx/mobx.dart';

class ScreensSelect extends StatelessWidget {
  final ObservableList<SchemaStore> screens;
  final GoToScreenAction action;
  final UserActions userActions;

  const ScreensSelect(
      {Key key,
      @required this.userActions,
      @required this.action,
      @required this.screens})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    log('length screens ${screens.length}');
    //
    return Column(
      children: buildActions(),
    );
  }

  List<Widget> buildActions() {
    return screens
        .map((schemaStore) => GestureDetector(
            onTap: () => {
                  log('Screen ${schemaStore.name}'),
                  userActions.changePropertyTo(
                      GoToScreenAction('Tap', schemaStore.name)),
                  log('Action ${action.value}'),
                },
            child: Container(
                child: Text(schemaStore.name,
                    style: TextStyle(
                        color: action.value == schemaStore.name
                            ? Colors.red
                            : Colors.black)))))
        .toList();
  }
}
