import 'package:flutter/material.dart';
import 'package:flutter_app/store/schema/bottom_navigation/tab_navigation.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_app/utils/RandomKey.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppTabs extends StatelessWidget {
  final List<TabNavigation> tabs;
  final Function(TabNavigation) onTap;
  final RandomKey selectedScreenId;
  final MyTheme theme;

  const AppTabs({
    Key key,
    @required this.tabs,
    @required this.onTap,
    @required this.selectedScreenId,
    @required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: tabs
            .map((tab) => Expanded(
                  child: GestureDetector(
                    onTap: () {
                      onTap(tab);
                    },
                    child: Cursor(
                      cursor: CursorEnum.pointer,
                      child: AppTabItem(
                        tab: tab,
                        activeColor: theme.primary.color,
                        disabledColor: theme.generalSecondary.color,
                        isActive: tab.target == selectedScreenId,
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class AppTabItem extends StatelessWidget {
  final TabNavigation tab;
  final bool isActive;
  final Color activeColor;
  final Color disabledColor;

  const AppTabItem({
    Key key,
    this.tab,
    this.isActive = false,
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
