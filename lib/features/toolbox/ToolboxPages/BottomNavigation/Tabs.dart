import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/store/schema/BottomNavigationStore.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class Tabs extends StatelessWidget {
  final UserActions userActions;

  const Tabs({Key key, @required this.userActions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10.0),
          child: Container(
              child: Column(
            children: userActions.bottomNavigation.tabs
                .map((tab) => TabItem(tab: tab))
                .toList(),
          )),
        );
      },
    );
  }
}

class TabItem extends StatelessWidget {
  final TabNavigation tab;

  const TabItem({Key key, this.tab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
          decoration: BoxDecoration(
              gradient: MyGradients.buttonLightWhite,
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(width: 1, color: MyColors.gray)),
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 9.0, bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(child: Text('icon')),
                SizedBox(
                  width: 8,
                ),
                Text(tab.label)
              ],
            ),
          )),
    );
  }
}
