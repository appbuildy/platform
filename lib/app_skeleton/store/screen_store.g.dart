// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screen_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ScreenStore on _ScreenStore, Store {
  final _$currentScreenAtom = Atom(name: '_ScreenStore.currentScreen');

  @override
  Screen get currentScreen {
    _$currentScreenAtom.reportRead();
    return super.currentScreen;
  }

  @override
  set currentScreen(Screen value) {
    _$currentScreenAtom.reportWrite(value, super.currentScreen, () {
      super.currentScreen = value;
    });
  }

  final _$_ScreenStoreActionController = ActionController(name: '_ScreenStore');

  @override
  void setCurrentScreen(Screen screen) {
    final _$actionInfo = _$_ScreenStoreActionController.startAction(
        name: '_ScreenStore.setCurrentScreen');
    try {
      return super.setCurrentScreen(screen);
    } finally {
      _$_ScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentScreen: ${currentScreen}
    ''';
  }
}
