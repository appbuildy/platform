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

  const BottomNavigation(this.tabs);

  factory BottomNavigation.fromJson(Map<String, dynamic> jsonNav) {
    final tabs = jsonNav['tabs']
        .map<TabNavigation>(
          (dynamic tab) => TabNavigation.fromJson(tab),
        )
        .toList();

    return BottomNavigation(tabs);
  }

  @override
  Widget build(BuildContext context) {
    var theme = MyThemes.allThemes['blue'];
    var isVisible = true;
    final store = Provider.of<ScreenStore>(context);

    return Positioned(
      bottom: 0,
      left: 0,
      child: isVisible
          ? DecoratedBox(
              decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                  width: 1,
                  color: theme.separators.color,
                )),
              ),
              child: Container(
                width: 375,
                height: 82,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.zero,
                ),
                child: Observer(
                  builder: (_) => AppTabs(
                    selectedScreenId: store.selectedScreenId,
                    tabs: tabs,
                    theme: theme,
                    onTap: (tab) {
                      store.setCurrentScreen(store.screens[tab.target]);
                    },
                  ),
                ),
              ),
            )
          : Container(),
    );
  }
}
