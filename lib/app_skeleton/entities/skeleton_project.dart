import 'dart:convert';

import 'package:flutter_app/app_skeleton/entities/skeleton_entities.dart';
import 'package:flutter_app/utils/RandomKey.dart';

/// project data: screens and navBar data
class SkeletonProject {
  final Map<RandomKey, SkeletonScreen> screens;
  final SkeletonNavBar navBar;
  const SkeletonProject({this.screens, this.navBar});

  Map<String, dynamic> toMap() {
    return {
      'canvas': {
        'screens': screens?.map((x) => x?.toMap())?.toList(),
        'bottomNavigation': navBar?.toMap(),
      }
    };
  }

  factory SkeletonProject.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    // unpack nav bar
    final SkeletonNavBar navBar =
        SkeletonNavBar.fromMap(map['canvas']['bottomNavigation']);

    return SkeletonProject(
      screens: Map<RandomKey, SkeletonScreen>.fromIterable(
            map['canvas']['screens']?.map<SkeletonScreen>(
                (dynamic screenData) =>
                    SkeletonScreen.fromMap(map: screenData, navBar: navBar)),
            key: (dynamic screen) => screen.id,
            value: (dynamic screen) => screen,
          ) ??
          <RandomKey, SkeletonScreen>{},
      navBar: navBar,
    );
  }

  String toJson() => json.encode(toMap());

  factory SkeletonProject.fromJson(String source) =>
      SkeletonProject.fromMap(json.decode(source));
}
