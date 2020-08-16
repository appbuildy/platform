// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ConstructorCanvas.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ConstructorCanvas on _ConstructorCanvas, Store {
  final _$componentsAtom = Atom(name: '_ConstructorCanvas.components');

  @override
  List<WidgetWrapper> get components {
    _$componentsAtom.reportRead();
    return super.components;
  }

  @override
  set components(List<WidgetWrapper> value) {
    _$componentsAtom.reportWrite(value, super.components, () {
      super.components = value;
    });
  }

  final _$_ConstructorCanvasActionController =
      ActionController(name: '_ConstructorCanvas');

  @override
  void add(WidgetWrapper widgetWrapper) {
    final _$actionInfo = _$_ConstructorCanvasActionController.startAction(
        name: '_ConstructorCanvas.add');
    try {
      return super.add(widgetWrapper);
    } finally {
      _$_ConstructorCanvasActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
components: ${components}
    ''';
  }
}
