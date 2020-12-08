import 'package:flutter/cupertino.dart';
import 'package:flutter_app/utils/FontAwesomeIconsExtension.dart';
import 'package:flutter_app/utils/RandomKey.dart';

/// navigation tab data
class TabNavigation {
  RandomKey id;
  String label;
  IconData icon;
  RandomKey target;

  TabNavigation({
    RandomKey id,
    this.label,
    this.icon,
    this.target,
  }) : this.id = id ?? RandomKey();

  factory TabNavigation.fromJson(Map<String, dynamic> jsonVal) {
    return TabNavigation(
      id: RandomKey.fromJson(jsonVal['id']),
      label: jsonVal['label'],
      target: RandomKey.fromJson(jsonVal['target']),
      icon: JsonSerializationIconData.fromJson(jsonVal['icon']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toJson(),
      'label': label,
      'icon': icon.toJson(),
      'target': target.toJson(),
    };
  }
}
