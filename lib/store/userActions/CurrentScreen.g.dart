// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CurrentScreen.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CurrentScreen on _CurrentScreen, Store {
  final _$currentScreenAtom = Atom(name: '_CurrentScreen.currentScreen');

  @override
  SchemaStore get currentScreen {
    _$currentScreenAtom.reportRead();
    return super.currentScreen;
  }

  @override
  set currentScreen(SchemaStore value) {
    _$currentScreenAtom.reportWrite(value, super.currentScreen, () {
      super.currentScreen = value;
    });
  }

  final _$_CurrentScreenActionController =
      ActionController(name: '_CurrentScreen');

  @override
  void select(SchemaStore screen) {
    final _$actionInfo = _$_CurrentScreenActionController.startAction(
        name: '_CurrentScreen.select');
    try {
      return super.select(screen);
    } finally {
      _$_CurrentScreenActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentScreen: ${currentScreen}
    ''';
  }
}
