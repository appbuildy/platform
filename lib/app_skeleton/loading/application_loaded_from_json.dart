import 'package:flutter_app/app_skeleton/application.dart';
import 'package:flutter_app/app_skeleton/screen.dart';
import 'package:flutter_app/app_skeleton/widgets/bottom_navigation.dart';
import 'package:flutter_app/utils/RandomKey.dart';

import 'i_application_load.dart';

class ApplicationLoadedFromJson implements IApplicationLoad {
  Map<String, dynamic> jsonApp;
  ApplicationLoadedFromJson(this.jsonApp);

  @override
  Application load() {
    var bottomNav = _loadBottomNavigation();
    return Application(screens: _loadScreens(bottomNav));
  }

  BottomNavigation _loadBottomNavigation() {
    return BottomNavigation.fromJson(jsonApp['canvas']['bottomNavigation']);
  }

  Map<RandomKey, Screen> _loadScreens(bottomNavigation) {
    Map<RandomKey, Screen> map = {};
    jsonApp['canvas']['screens'].forEach((screen) {
      var deserializedScreen =
          Screen.fromJson(screen, bottomNavigator: bottomNavigation);
      map[deserializedScreen.id] = deserializedScreen;
    });
    return map;
  }
}
