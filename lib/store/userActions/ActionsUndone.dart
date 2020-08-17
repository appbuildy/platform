import 'package:flutter_app/features/schemaInteractions/BaseAction.dart';
import 'package:mobx/mobx.dart';

part 'ActionsUndone.g.dart';

class ActionsUndone = _ActionsUndone with _$ActionsUndone;

abstract class _ActionsUndone with Store {
  _ActionsUndone({List<BaseAction> actions}) {
    this.actions = actions;
  }

  @observable
  List<BaseAction> actions = [];

  @action
  void add(BaseAction action) {
    actions.add(action);
  }
}
