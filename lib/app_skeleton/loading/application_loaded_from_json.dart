import 'package:flutter_app/app_skeleton/application.dart';
import 'package:flutter_app/app_skeleton/screen.dart';
import 'package:flutter_app/app_skeleton/widgets/bottom_navigation.dart';
import 'package:flutter_app/features/entities/Project.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_app/utils/RandomKey.dart';

import 'i_application_load.dart';

class ApplicationLoadedFromJson implements IApplicationLoad {
  Project project;
  ApplicationLoadedFromJson(this.project);

  Map<String, dynamic> get jsonApp => project.data;

  @override
  Application load() {
    var theme = _loadTheme();
    var bottomNav = _loadBottomNavigation(theme);
    return Application(theme: theme, screens: _loadScreens(bottomNav, theme));
  }

  _loadTheme() {
    return MyTheme.fromJson(jsonApp['canvas']['theme']);
  }

  BottomNavigation _loadBottomNavigation(theme) {
    return BottomNavigation.fromJson(jsonApp['canvas']['bottomNavigation'],
        currentTheme: theme);
  }

  Map<RandomKey, Screen> _loadScreens(bottomNavigation, [theme]) {
    Map<RandomKey, Screen> map = {};
    jsonApp['canvas']['screens'].forEach((screen) {
      var deserializedScreen = Screen.fromJson(screen,
          bottomNavigation: bottomNavigation, project: project, theme: theme);
      map[deserializedScreen.id] = deserializedScreen;
    });
    return map;
  }
}
