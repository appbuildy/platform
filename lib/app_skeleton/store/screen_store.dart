import 'package:flutter_app/app_skeleton/screen.dart';
import 'package:flutter_app/utils/RandomKey.dart';
import 'package:mobx/mobx.dart';

part 'screen_store.g.dart';

class ScreenStore = _ScreenStore with _$ScreenStore;

abstract class _ScreenStore with Store {
  _ScreenStore(this.currentScreen, this.screens);

  @observable
  Screen currentScreen;

  @computed
  RandomKey get selectedScreenId => currentScreen.id;

  Map<RandomKey, Screen> screens;

  @action
  void setCurrentScreen(Screen screen) {
    currentScreen = screen;
  }
}
