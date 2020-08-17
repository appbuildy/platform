// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CurrentEditingElement.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CurrentEditingNode on _CurrentEditingNode, Store {
  final _$selectedElementAtom =
      Atom(name: '_CurrentEditingElement.selectedElement');

  @override
  SchemaNode get selectedNode {
    _$selectedElementAtom.reportRead();
    return super.selectedNode;
  }

  @override
  set selectedNode(SchemaNode value) {
    _$selectedElementAtom.reportWrite(value, super.selectedNode, () {
      super.selectedNode = value;
    });
  }

  final _$_CurrentEditingElementActionController =
      ActionController(name: '_CurrentEditingElement');

  @override
  void select(SchemaNode node) {
    final _$actionInfo = _$_CurrentEditingElementActionController.startAction(
        name: '_CurrentEditingElement.select');
    try {
      return super.select(node);
    } finally {
      _$_CurrentEditingElementActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedElement: ${selectedNode}
    ''';
  }
}
