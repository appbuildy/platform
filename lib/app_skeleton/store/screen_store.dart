import 'package:flutter_app/app_skeleton/entities/skeleton_screen.dart';
import 'package:flutter_app/utils/RandomKey.dart';
import 'package:mobx/mobx.dart';

part 'screen_store.g.dart';

class ScreenStore = _ScreenStore with _$ScreenStore;

abstract class _ScreenStore with Store {
  _ScreenStore(this.currentScreen, this.screens);

  @observable
  SkeletonScreen currentScreen;

  @computed
  RandomKey get selectedScreenId => currentScreen.id;

  Map<RandomKey, SkeletonScreen> screens;

  @action
  void setCurrentScreen(SkeletonScreen screen) {
    currentScreen = screen;
  }
}
