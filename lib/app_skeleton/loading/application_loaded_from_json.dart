import 'package:flutter_app/app_skeleton/application.dart';
import 'package:flutter_app/app_skeleton/screen.dart';

import 'i_application_load.dart';

class ApplicationLoadedFromJson implements IApplicationLoad {
  Map<String, dynamic> jsonApp;
  ApplicationLoadedFromJson(this.jsonApp);

  @override
  Application load() {
    return Application(screens: _loadScreens());
  }

  List<Screen> _loadScreens() {
    return jsonApp['canvas']['screens']
        .map((screen) {
          return Screen.fromJson(screen);
        })
        .toList()
        .cast<Screen>();
  }
}
