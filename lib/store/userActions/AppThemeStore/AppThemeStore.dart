import 'package:mobx/mobx.dart';

import 'MyThemes.dart';

part 'AppThemeStore.g.dart';

class AppThemeStore = _AppThemeStore with _$AppThemeStore;

abstract class _AppThemeStore with Store {
  @observable
  MyTheme currentTheme;

  @action
  void setTheme(MyTheme theme) {
    currentTheme = theme;
  }
}
