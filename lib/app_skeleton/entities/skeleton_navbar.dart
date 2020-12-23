import 'dart:convert';

import 'package:flutter_app/store/schema/bottom_navigation/tab_navigation.dart';

/// bottom navigation bar and its content data
class SkeletonNavBar {
  final List<TabNavigation> tabs;

  const SkeletonNavBar({
    this.tabs,
  });

  Map<String, dynamic> toMap() {
    return {
      'tabs': tabs?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory SkeletonNavBar.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SkeletonNavBar(
      tabs: List<TabNavigation>.from(
        map['tabs']?.map(TabNavigation.fromMap),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory SkeletonNavBar.fromJson(String source) =>
      SkeletonNavBar.fromMap(json.decode(source));
}
