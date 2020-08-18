import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:mobx/mobx.dart';

part 'CurrentScren.g.dart';

class CurrentScreen = _CurrentScreen with _$CurrentScreen;

abstract class _CurrentScreen with Store {
  @observable
  SchemaStore currentScreen;

  @action
  void select(SchemaStore screen) {
    currentScreen = screen;
  }
}
