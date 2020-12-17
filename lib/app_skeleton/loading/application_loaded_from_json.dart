import 'package:flutter_app/app_skeleton/application.dart';
import 'package:flutter_app/app_skeleton/loading/i_loader.dart';
import 'package:flutter_app/app_skeleton/screen.dart';
import 'package:flutter_app/app_skeleton/widgets/bottom_navigation.dart';
import 'package:flutter_app/utils/RandomKey.dart';

class ApplicationLoadedFromJson implements ILoader<Application> {
  Map<String, dynamic> jsonApp;
  ApplicationLoadedFromJson(this.jsonApp);

  @override
  Application load() {
    var bottomNav = _loadBottomNavigation();
    return Application(screens: _loadScreens(bottomNav));
  }

  AppBuildyBottomNavBar _loadBottomNavigation() {
    return AppBuildyBottomNavBar.fromJson(
      jsonApp['canvas']['bottomNavigation'],
    );
  }

  Map<RandomKey, Screen> _loadScreens(bottomNavigation) {
    Map<RandomKey, Screen> map = {};
    jsonApp['canvas']['screens'].forEach((screen) {
      var deserializedScreen =
          Screen.fromJson(screen, botNavBar: bottomNavigation);
      map[deserializedScreen.id] = deserializedScreen;
    });
    return map;
  }
}
