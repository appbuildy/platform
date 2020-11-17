import 'package:flutter_app/app_skeleton/application.dart';
import 'package:flutter_app/app_skeleton/screen.dart';
import 'package:flutter_app/utils/RandomKey.dart';

import 'i_application_load.dart';

class ApplicationLoadedFromJson implements IApplicationLoad {
  Map<String, dynamic> jsonApp;
  ApplicationLoadedFromJson(this.jsonApp);

  @override
  Application load() {
    return Application(screens: _loadScreens());
  }

  Map<RandomKey, Screen> _loadScreens() {
    Map<RandomKey, Screen> map = {};
    jsonApp['canvas']['screens'].forEach((screen) {
      map[RandomKey()] = Screen.fromJson(screen);
    });
    return map;
  }
}
