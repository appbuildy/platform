import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:mobx/mobx.dart';

part 'BottomNavigationStore.g.dart';

class TabNavigation {
  final String label;
  final String icon;
  final String target;
  UniqueKey id;

  TabNavigation({this.target, this.label, this.icon}) {
    this.id = UniqueKey();
  }
}

class BottomNavigationStore = _BottomNavigationStore
    with _$BottomNavigationStore;

abstract class _BottomNavigationStore with Store {
  _BottomNavigationStore() {
    this.tabs.addAll([
      TabNavigation(label: 'Home', icon: 'home', target: 'Main'),
      TabNavigation(label: 'Search', icon: 'search', target: 'Page 2'),
      TabNavigation(label: 'Calendar', icon: 'stats', target: 'Page 3'),
      TabNavigation(label: 'Settings', icon: 'home', target: 'Page 4')
    ]);
  }

  @observable
  ObservableList<TabNavigation> tabs = ObservableList<TabNavigation>();

  @action
  void addTab(TabNavigation tab) {
    tabs.add(tab);
  }

  @action
  void deleteTab(TabNavigation tab) {
    tabs.remove(tab);
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
