import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_app/app_skeleton/entities/skeleton_entities.dart';
import 'package:flutter_app/config/constants.dart';
import 'package:flutter_app/utils/RandomKey.dart';

/// screen content data
class SkeletonScreen {
  /// screen id
  final RandomKey id;

  /// props of layout from builder
  final SkeletonScreenSize size;

  /// body layout
  final List<SkeletonWidget> widgets;

  /// bottom navigation bar, if any
  final SkeletonNavBar navBar;
  bool get showNavBar => navBar != null;

  SkeletonScreen({
    this.id,
    @required this.widgets,
    this.navBar,
    this.size = defaultSkeletonScreenSize,
  });

  /// parse jsonified widgets data
  factory SkeletonScreen.fromMap({
    Map<String, dynamic> map,
    SkeletonNavBar navBar,
  }) {
    if (map == null) return null;

    return SkeletonScreen(
      id: RandomKey.fromJson(map['id']),
      widgets: map['components']
          .map<SkeletonWidget>(SkeletonWidget.fromMap)
          .toList(),
      navBar: navBar,
    );
  }

  factory SkeletonScreen.fromJson({
    String source,
    SkeletonNavBar navBar,
  }) {
    return SkeletonScreen.fromMap(map: json.decode(source), navBar: navBar);
  }
}
