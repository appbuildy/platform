import 'package:flutter_app/app_skeleton/application.dart';
import 'package:flutter_app/app_skeleton/entities/skeleton_screen.dart';
import 'package:flutter_app/app_skeleton/widgets/bottom_navigation.dart';
import 'package:flutter_app/features/entities/Project.dart';
import 'package:flutter_app/utils/RandomKey.dart';

import 'i_application_load.dart';

class ApplicationLoadedFromJson implements IApplicationLoad {
  Project project;
  ApplicationLoadedFromJson(this.project);

  Map<String, dynamic> get jsonApp => project.data;

  @override
  Application load() {
    var bottomNav = _loadBottomNavigation();
    return Application(screens: _loadScreens(bottomNav));
  }

  BottomNavigation _loadBottomNavigation() {
    return BottomNavigation.fromJson(jsonApp['canvas']['bottomNavigation']);
  }

  Map<RandomKey, SkeletonScreen> _loadScreens(bottomNavigation) {
    Map<RandomKey, SkeletonScreen> map = {};
    jsonApp['canvas']['screens'].forEach((jsonScreen) {
      map[jsonScreen['id']] = SkeletonScreen.fromJson(
        json: jsonScreen,
        navBar: bottomNavigation,
        project: project,
      );
      ;
    });
    return map;
  }
}
