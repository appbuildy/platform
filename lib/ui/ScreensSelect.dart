import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/schemaAction.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:mobx/mobx.dart';

class ScreensSelect extends StatelessWidget {
  final ObservableList<SchemaStore> screens;
  GoToScreenAction action;

  ScreensSelect({Key key, @required action, @required this.screens})
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
        .map((schemaStore) => Container(child: Text(schemaStore.name)))
        .toList();
  }
}
