// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppThemeStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppThemeStore on _AppThemeStore, Store {
  final _$currentThemeAtom = Atom(name: '_AppThemeStore.currentTheme');

  @override
  MyTheme get currentTheme {
    _$currentThemeAtom.reportRead();
    return super.currentTheme;
  }

  @override
  set currentTheme(MyTheme value) {
    _$currentThemeAtom.reportWrite(value, super.currentTheme, () {
      super.currentTheme = value;
    });
  }

  final _$_AppThemeStoreActionController =
      ActionController(name: '_AppThemeStore');

  @override
  void setTheme(MyTheme theme) {
    final _$actionInfo = _$_AppThemeStoreActionController.startAction(
        name: '_AppThemeStore.setTheme');
    try {
      return super.setTheme(theme);
    } finally {
      _$_AppThemeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentTheme: ${currentTheme}
    ''';
  }
}
