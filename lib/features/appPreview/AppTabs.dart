import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';

class AppTabs extends StatelessWidget {
  final UserActions userActions;

  const AppTabs({Key key, this.userActions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: userActions.bottomNavigation.tabs
          .map((tab) => Column(
                children: [
                  Text(tab.icon),
                  Text(
                    tab.label,
                    style: TextStyle(fontSize: 10),
                  )
                ],
              ))
          .toList(),
    );
  }
}
