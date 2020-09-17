import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/store/schema/BottomNavigationStore.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppTabs extends StatelessWidget {
  final UserActions userActions;

  const AppTabs({Key key, this.userActions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: userActions.bottomNavigation.tabs
                .map((tab) => Expanded(
                      child: GestureDetector(
                        onTap: () {
                          userActions.screens.selectById(tab.target);
                        },
                        child: Cursor(
                          cursor: CursorEnum.pointer,
                          child: AppTabItem(
                            tab: tab,
                            bottomNavigation: userActions.bottomNavigation,
                            activeColor:
                                userActions.theme.currentTheme.primary.color,
                            disabledColor: userActions
                                .theme.currentTheme.generalSecondary.color,
                            isActive:
                                tab.target == userActions.currentScreen.id,
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
        );
      },
    );
  }
}

class AppTabItem extends StatelessWidget {
  final TabNavigation tab;
  final BottomNavigationStore bottomNavigation;
  final bool isActive;
  final Color activeColor;
  final Color disabledColor;

  const AppTabItem({
    Key key,
    this.tab,
    this.isActive = false,
    this.bottomNavigation,
    this.activeColor,
    this.disabledColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FaIcon(
          tab.icon,
          color: isActive ? activeColor : disabledColor,
          size: 28,
        ),
        SizedBox(
          height: 2,
        ),
        Text(
          tab.label,
          style: TextStyle(
              fontSize: 10, color: isActive ? activeColor : disabledColor),
        )
      ],
    );
  }
}
