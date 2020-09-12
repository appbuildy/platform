// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RemoteAttributes.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RemoteAttributes on _RemoteAttributes, Store {
  final _$attributesAtom = Atom(name: '_RemoteAttributes.attributes');

  @override
  ObservableList<String> get attributes {
    _$attributesAtom.reportRead();
    return super.attributes;
  }

  @override
  set attributes(ObservableList<String> value) {
    _$attributesAtom.reportWrite(value, super.attributes, () {
      super.attributes = value;
    });
  }

  final _$_RemoteAttributesActionController =
      ActionController(name: '_RemoteAttributes');

  @override
  void updateAttributes(ObservableList<String> list) {
    final _$actionInfo = _$_RemoteAttributesActionController.startAction(
        name: '_RemoteAttributes.updateAttributes');
    try {
      return super.updateAttributes(list);
    } finally {
      _$_RemoteAttributesActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
attributes: ${attributes}
    ''';
  }
}
