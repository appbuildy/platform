import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobx/mobx.dart';

part 'BottomNavigationStore.g.dart';

class TabNavigation {
  String label;
  IconData icon;
  String target;
  UniqueKey id;

  TabNavigation({this.target, this.label, this.icon, this.id}) {
    this.id = id ?? UniqueKey();
  }
}

class BottomNavigationStore = _BottomNavigationStore
    with _$BottomNavigationStore;

abstract class _BottomNavigationStore with Store {
  _BottomNavigationStore() {
    this.tabs.addAll([
      TabNavigation(label: 'Home', icon: FontAwesomeIcons.home, target: 'Main'),
      TabNavigation(
          label: 'Search', icon: FontAwesomeIcons.search, target: 'Page 2'),
      TabNavigation(
          label: 'Calendar', icon: FontAwesomeIcons.calendar, target: 'Page 3'),
      TabNavigation(
          label: 'Settings', icon: FontAwesomeIcons.cog, target: 'Page 4')
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
    log('delete tab');
    final index = tabs.indexWhere((element) => element.id == tab.id);
    tabs.removeAt(index);
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
