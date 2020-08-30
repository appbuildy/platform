// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ActionsDone.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ActionsDone on _ActionsDone, Store {
  Computed<bool> _$isActionsEmptyComputed;

  @override
  bool get isActionsEmpty =>
      (_$isActionsEmptyComputed ??= Computed<bool>(() => super.isActionsEmpty,
              name: '_ActionsDone.isActionsEmpty'))
          .value;

  final _$actionsAtom = Atom(name: '_ActionsDone.actions');

  @override
  ObservableList<BaseAction> get actions {
    _$actionsAtom.reportRead();
    return super.actions;
  }

  @override
  set actions(ObservableList<BaseAction> value) {
    _$actionsAtom.reportWrite(value, super.actions, () {
      super.actions = value;
    });
  }

  final _$_ActionsDoneActionController = ActionController(name: '_ActionsDone');

  @override
  void add(BaseAction action) {
    final _$actionInfo =
        _$_ActionsDoneActionController.startAction(name: '_ActionsDone.add');
    try {
      return super.add(action);
    } finally {
      _$_ActionsDoneActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
actions: ${actions},
isActionsEmpty: ${isActionsEmpty}
    ''';
  }
}
