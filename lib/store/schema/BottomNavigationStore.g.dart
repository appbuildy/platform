// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BottomNavigationStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BottomNavigationStore on _BottomNavigationStore, Store {
  final _$tabsAtom = Atom(name: '_BottomNavigationStore.tabs');

  @override
  ObservableList<TabNavigation> get tabs {
    _$tabsAtom.reportRead();
    return super.tabs;
  }

  @override
  set tabs(ObservableList<TabNavigation> value) {
    _$tabsAtom.reportWrite(value, super.tabs, () {
      super.tabs = value;
    });
  }

  final _$isLabelsVisibleAtom =
      Atom(name: '_BottomNavigationStore.isLabelsVisible');

  @override
  bool get isLabelsVisible {
    _$isLabelsVisibleAtom.reportRead();
    return super.isLabelsVisible;
  }

  @override
  set isLabelsVisible(bool value) {
    _$isLabelsVisibleAtom.reportWrite(value, super.isLabelsVisible, () {
      super.isLabelsVisible = value;
    });
  }

  final _$colorAtom = Atom(name: '_BottomNavigationStore.color');

  @override
  Color get color {
    _$colorAtom.reportRead();
    return super.color;
  }

  @override
  set color(Color value) {
    _$colorAtom.reportWrite(value, super.color, () {
      super.color = value;
    });
  }

  final _$_BottomNavigationStoreActionController =
      ActionController(name: '_BottomNavigationStore');

  @override
  void addTab(TabNavigation tab) {
    final _$actionInfo = _$_BottomNavigationStoreActionController.startAction(
        name: '_BottomNavigationStore.addTab');
    try {
      return super.addTab(tab);
    } finally {
      _$_BottomNavigationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteTab(TabNavigation tab) {
    final _$actionInfo = _$_BottomNavigationStoreActionController.startAction(
        name: '_BottomNavigationStore.deleteTab');
    try {
      return super.deleteTab(tab);
    } finally {
      _$_BottomNavigationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateTab(TabNavigation tab) {
    final _$actionInfo = _$_BottomNavigationStoreActionController.startAction(
        name: '_BottomNavigationStore.updateTab');
    try {
      return super.updateTab(tab);
    } finally {
      _$_BottomNavigationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleIsLabelsVisible() {
    final _$actionInfo = _$_BottomNavigationStoreActionController.startAction(
        name: '_BottomNavigationStore.toggleIsLabelsVisible');
    try {
      return super.toggleIsLabelsVisible();
    } finally {
      _$_BottomNavigationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setColor(Color newColor) {
    final _$actionInfo = _$_BottomNavigationStoreActionController.startAction(
        name: '_BottomNavigationStore.setColor');
    try {
      return super.setColor(newColor);
    } finally {
      _$_BottomNavigationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
tabs: ${tabs},
isLabelsVisible: ${isLabelsVisible},
color: ${color}
    ''';
  }
}
