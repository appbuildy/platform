// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ActionsUndone.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ActionsUndone on _ActionsUndone, Store {
  final _$actionsAtom = Atom(name: '_ActionsUndone.actions');

  @override
  List<BaseAction> get actions {
    _$actionsAtom.reportRead();
    return super.actions;
  }

  @override
  set actions(List<BaseAction> value) {
    _$actionsAtom.reportWrite(value, super.actions, () {
      super.actions = value;
    });
  }

  final _$_ActionsUndoneActionController =
      ActionController(name: '_ActionsUndone');

  @override
  void add(BaseAction action) {
    final _$actionInfo = _$_ActionsUndoneActionController.startAction(
        name: '_ActionsUndone.add');
    try {
      return super.add(action);
    } finally {
      _$_ActionsUndoneActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
actions: ${actions}
    ''';
  }
}
