import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/schemaAction.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MySelects/MySelects.dart';
import 'package:flutter_app/ui/MySwitch.dart';
import 'package:mobx/mobx.dart';

class AllActions extends StatelessWidget {
  final ObservableList<SchemaStore> screens;
  final UserActions userActions;

  const AllActions(
      {Key key, @required this.userActions, @required this.screens})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("userActions.selectedNode().actions['Tap'].value ${userActions.selectedNode().actions['Tap'].value}");
    final selectedNode = userActions.selectedNode();

    return Column(
      children: [
        Row(
          children: [
            MySwitch(
              value: false,
              onTap: () {},
            ),
            SizedBox(width: 11),
            Text(
              'Navigate to Page on tap',
              style: MyTextStyle.regularTitle,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Navigate to',
              style: MyTextStyle.regularCaption,
            ),
            Container(
              width: 170,
              child: MyClickSelect(
                  placeholder: 'Select Page',
                  selectedValue: selectedNode.actions['Tap'].value ?? null,
                  onChange: (screen) {
                    log('change screen value FUCKER');
                    userActions
                        .changeActionTo(GoToScreenAction('Tap', screen.value));
                  },
                  options: userActions.screens.all.screens
                      .map((element) => SelectOption(element.name, element.id))
                      .toList()),
            )
          ],
        ),
//        ScreensSelect(
//            userActions: userActions,
//            action: userActions.selectedNode().actions['Tap'],
//            screens: screens),
      ],
    );
  }
}
