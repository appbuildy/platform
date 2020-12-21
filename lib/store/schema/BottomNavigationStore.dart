import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/layout/MAIN_UNIQUE_KEY.dart';
import 'package:flutter_app/store/schema/bottom_navigation/tab_navigation.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobx/mobx.dart';

part 'BottomNavigationStore.g.dart';

class BottomNavigationStore = _BottomNavigationStore
    with _$BottomNavigationStore;

abstract class _BottomNavigationStore with Store {
  _BottomNavigationStore([List<TabNavigation> tabs]) {
    this.tabs.addAll([
      tabs ??
          TabNavigation(
              label: 'Home',
              icon: FontAwesomeIcons.home,
              target: MAIN_UNIQUE_KEY),
    ]);
  }

  _BottomNavigationStore.fromJson(Map<String, dynamic> jsonVal) {
    var tabs = jsonVal['tabs']
        .map((tab) => TabNavigation.fromJson(tab))
        .toList()
        .cast<TabNavigation>();
    this.tabs.addAll(tabs);
  }

  Map<String, dynamic> toJson() {
    return {'tabs': tabs.map((tab) => tab.toJson()).toList()};
  }

  @observable
  ObservableList<TabNavigation> tabs = ObservableList<TabNavigation>();

  @action
  void addTab(TabNavigation tab) {
    tabs.add(tab);
  }

  @action
  void deleteTab(TabNavigation tab) {
    log('delete tab');
    tabs.removeWhere((element) => element.id == tab.id);
  }

  @action
  void updateTab(TabNavigation tab) {
    final index = tabs.indexWhere((element) => element.id == tab.id);
    tabs.replaceRange(index, index + 1, [tab]);
  }

  @observable
  bool isLabelsVisible = true;

  @action
  void toggleIsLabelsVisible() {
    isLabelsVisible = !isLabelsVisible;
  }

  @observable
  Color color = MyColors.mainBlue;

  @action
  void setColor(Color newColor) {
    color = newColor;
  }
}
