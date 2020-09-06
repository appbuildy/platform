import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/store/schema/BottomNavigationStore.dart';

class AppTabs extends StatelessWidget {
  final UserActions userActions;

  const AppTabs({Key key, this.userActions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: userActions.bottomNavigation.tabs
          .map((tab) => AppTabItem(
                tab: tab,
                bottomNavigation: userActions.bottomNavigation,
                isActive: tab.target == userActions.currentScreen.name,
              ))
          .toList(),
    );
  }
}

class AppTabItem extends StatelessWidget {
  final TabNavigation tab;
  final BottomNavigationStore bottomNavigation;
  final bool isActive;

  const AppTabItem(
      {Key key, this.tab, this.isActive = false, this.bottomNavigation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(tab.icon),
        Text(
          tab.label,
          style: TextStyle(
              fontSize: 10, color: isActive ? bottomNavigation.color : null),
        )
      ],
    );
  }
}
