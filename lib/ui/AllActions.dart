import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:mobx/mobx.dart';

class AllActions extends StatelessWidget {
  final ObservableList<SchemaStore> screens;

  const AllActions({Key key, @required this.screens}) : super(key: key);

  List<Widget> buildActions() {
    return screens
        .map((schemaStore) => Container(child: Text(schemaStore.name)))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    log('length screens ${screens.length}');
//
    return Column(
      children: buildActions(),
    );
  }
}
