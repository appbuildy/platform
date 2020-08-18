// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ScreensStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ScreensStore on _ScreensStore, Store {
  final _$screensAtom = Atom(name: '_ScreensStore.screens');

  @override
  List<SchemaStore> get screens {
    _$screensAtom.reportRead();
    return super.screens;
  }

  @override
  set screens(List<SchemaStore> value) {
    _$screensAtom.reportWrite(value, super.screens, () {
      super.screens = value;
    });
  }

  final _$_ScreensStoreActionController =
      ActionController(name: '_ScreensStore');

  @override
  void createScreen(SchemaStore screen) {
    final _$actionInfo = _$_ScreensStoreActionController.startAction(
        name: '_ScreensStore.createScreen');
    try {
      return super.createScreen(screen);
    } finally {
      _$_ScreensStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
screens: ${screens}
    ''';
  }
}
