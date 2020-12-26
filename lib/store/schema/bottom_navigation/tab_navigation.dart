import 'package:flutter/cupertino.dart';
import 'package:flutter_app/utils/FontAwesomeIconsExtension.dart';
import 'package:flutter_app/utils/RandomKey.dart';

class TabNavigation {
  String label;
  IconData icon;
  RandomKey target;
  RandomKey id;

  TabNavigation({this.target, this.label, this.icon, this.id}){


    id ??= RandomKey();
  }

  TabNavigation.fromJson(Map<String, dynamic> jsonVal) {
    label = jsonVal['label'];
    target = RandomKey.fromJson(jsonVal['target']);
    id = RandomKey.fromJson(jsonVal['id']);
    icon = JsonSerializationIconData.fromJson(jsonVal['icon']);
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'target': target.toJson(),
      'id': id.toJson(),
      'icon': icon.toJson()
    };
  }
}
