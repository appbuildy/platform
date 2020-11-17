import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/appPreview/AppTabs.dart';
import 'package:flutter_app/store/schema/bottom_navigation/tab_navigation.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';

class BottomNavigation extends StatelessWidget {
  final List<TabNavigation> tabs;

  const BottomNavigation(this.tabs);

  factory BottomNavigation.fromJson(Map<String, dynamic> jsonNav) {
    var tabs = jsonNav['tabs']
        .map((tab) {
          return TabNavigation.fromJson(tab);
        })
        .toList()
        .cast<TabNavigation>();

    return BottomNavigation(tabs);
  }

  @override
  Widget build(BuildContext context) {
    var theme = MyThemes.allThemes['blue'];
    var isVisible = true;

    return Positioned(
      bottom: 0,
      left: 0,
      child: isVisible
          ? Container(
              decoration: BoxDecoration(
                  border: Border(
                      top:
                          BorderSide(width: 1, color: theme.separators.color))),
              child: Container(
                child: AppTabs(
                  selectedScreenId: null,
                  tabs: tabs,
                  theme: theme,
                  onTap: (tab) {},
                ),
                width: 375,
                height: 82,
                decoration: BoxDecoration(
                    color: Colors.transparent, borderRadius: BorderRadius.zero),
              ),
            )
          : Container(),
    );
  }
}
