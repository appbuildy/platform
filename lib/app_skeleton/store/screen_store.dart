import 'package:flutter_app/app_skeleton/screen.dart';
import 'package:mobx/mobx.dart';

part 'screen_store.g.dart';

class ScreenStore = _ScreenStore with _$ScreenStore;

abstract class _ScreenStore with Store {
  _ScreenStore(this.currentScreen);

  @observable
  Screen currentScreen;

  @action
  void setCurrentScreen(Screen screen) {}
}
