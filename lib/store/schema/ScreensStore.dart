import 'package:mobx/mobx.dart';

import 'SchemaStore.dart';

part 'ScreensStore.g.dart';

class ScreensStore = _ScreensStore with _$ScreensStore;

abstract class _ScreensStore with Store {
  _ScreensStore({List<SchemaStore> screens = const []}) {
    this.screens.addAll(screens);
  }

  @observable
  ObservableList<SchemaStore> screens = ObservableList<SchemaStore>();

  @action
  void createScreen(SchemaStore screen) {
    screens.add(screen);
  }

  void deleteScreen(SchemaStore screen) {
    screens.remove(screen);
  }
}
