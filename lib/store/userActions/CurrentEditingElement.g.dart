// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CurrentEditingElement.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CurrentEditingNode on _CurrentEditingNode, Store {
  final _$selectedNodeAtom = Atom(name: '_CurrentEditingNode.selectedNode');

  @override
  SchemaNode get selectedNode {
    _$selectedNodeAtom.reportRead();
    return super.selectedNode;
  }

  @override
  set selectedNode(SchemaNode value) {
    _$selectedNodeAtom.reportWrite(value, super.selectedNode, () {
      super.selectedNode = value;
    });
  }

  final _$_CurrentEditingNodeActionController =
      ActionController(name: '_CurrentEditingNode');

  @override
  void select(SchemaNode node) {
    final _$actionInfo = _$_CurrentEditingNodeActionController.startAction(
        name: '_CurrentEditingNode.select');
    try {
      return super.select(node);
    } finally {
      _$_CurrentEditingNodeActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedNode: ${selectedNode}
    ''';
  }
}
