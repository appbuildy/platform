import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/schemaAction.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_app/ui/ScreensSelect.dart';
import 'package:mobx/mobx.dart';

class AllActions extends StatelessWidget {
  final ObservableList<SchemaStore> screens;

  const AllActions({Key key, @required this.screens}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log('length screens ${screens.length}');
    return ScreensSelect(action: GoToScreenAction('Main'), screens: screens);
  }
}
