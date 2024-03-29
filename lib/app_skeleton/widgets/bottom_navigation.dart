import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app_skeleton/store/screen_store.dart';
import 'package:flutter_app/features/appPreview/AppTabs.dart';
import 'package:flutter_app/store/schema/bottom_navigation/tab_navigation.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatelessWidget {
  final List<TabNavigation> tabs;
  final MyTheme currentTheme;

  const BottomNavigation(this.tabs, this.currentTheme);

  factory BottomNavigation.fromJson(Map<String, dynamic> jsonNav,
      {MyTheme currentTheme}) {
    var tabs = jsonNav['tabs']
        .map((tab) {
          return TabNavigation.fromJson(tab);
        })
        .toList()
        .cast<TabNavigation>();

    return BottomNavigation(tabs, currentTheme);
  }

  @override
  Widget build(BuildContext context) {
    var theme = currentTheme ?? MyThemes.allThemes['blue'];
    var isVisible = true;
    final store = Provider.of<ScreenStore>(context);

    return isVisible
        ? Container(
            decoration: BoxDecoration(
                color: theme.background.color,
                border: Border(
                    top: BorderSide(width: 1, color: theme.separators.color))),
            child: Container(
              child: Observer(
                builder: (_) => AppTabs(
                  selectedScreenId: store.selectedScreenId,
                  tabs: tabs,
                  theme: theme,
                  onTap: (tab) {
                    store.setCurrentScreen(store.screens[tab.target]);

                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => store.currentScreen,
                        transitionDuration: Duration(seconds: 0),
                      ),
                    );
                  },
                ),
              ),
              width: 375,
              height: 82,
              decoration: BoxDecoration(
                  color: Colors.transparent, borderRadius: BorderRadius.zero),
            ),
          )
        : Container();
  }
}
