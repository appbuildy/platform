import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/store/schema/BottomNavigationStore.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/WithInfo.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Tabs extends StatelessWidget {
  final Function selectTab;
  final UserActions userActions;

  const Tabs({Key key, @required this.userActions, this.selectTab})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10.0),
          child: Container(
              child: Column(
            children: userActions.bottomNavigation.tabs
                .map((tab) => TabItem(
                    tab: tab,
                    userActions: userActions,
                    selectTab: () {
                      selectTab(tab);
                    }))
                .toList(),
          )),
        );
      },
    );
  }
}

class TabItem extends StatelessWidget {
  final TabNavigation tab;
  final Function selectTab;
  final UserActions userActions;

  const TabItem({Key key, this.tab, this.userActions, this.selectTab})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultDecoration = BoxDecoration(
        gradient: MyGradients.buttonLightWhite,
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(width: 1, color: MyColors.gray));

    final hoverDecoration = BoxDecoration(
        gradient: MyGradients.lightBlue,
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(width: 1, color: MyColors.mainBlue));

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: GestureDetector(
        onTap: selectTab,
        child: Cursor(
          cursor: CursorEnum.pointer,
          child: WithInfo(
            withDuplicateAndDelete: true,
            onDuplicate: () {
              userActions.bottomNavigation.addTab(TabNavigation(
                  icon: tab.icon, label: tab.label, target: tab.target));
            },
            onDelete: () {
              userActions.bottomNavigation.deleteTab(tab);
            },
            defaultDecoration: defaultDecoration,
            hoverDecoration: hoverDecoration,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 12.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 7, bottom: 2),
                    child: FaIcon(
                      tab.icon,
                      color: MyColors.iconDarkGray,
                      size: 22,
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    tab.label,
                    style: MyTextStyle.regularTitle,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
