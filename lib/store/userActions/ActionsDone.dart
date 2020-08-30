import 'package:flutter_app/features/schemaInteractions/BaseAction.dart';
import 'package:mobx/mobx.dart';

part 'ActionsDone.g.dart';

class ActionsDone = _ActionsDone with _$ActionsDone;

abstract class _ActionsDone with Store {
  _ActionsDone({List<BaseAction> actions}) {
    this.actions.addAll(actions);
  }

  @observable
  ObservableList<BaseAction> actions = ObservableList<BaseAction>();

  @computed
  bool get isActionsEmpty => actions.length <= 0;

  @action
  void add(BaseAction action) {
    actions.add(action);
  }
}
