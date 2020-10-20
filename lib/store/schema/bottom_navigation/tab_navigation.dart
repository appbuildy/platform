import 'package:flutter/cupertino.dart';
import 'package:flutter_app/utils/FontAwesomeIconsExtension.dart';
import 'package:flutter_app/utils/RandomKey.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TabNavigation {
  String label;
  IconData icon;
  RandomKey target;
  RandomKey id;

  TabNavigation({this.target, this.label, this.icon, this.id}) {
    this.id = id ?? RandomKey();
  }

  TabNavigation.fromJson(Map<String, dynamic> jsonVal) {
    this.label = jsonVal['label'];
    this.target = RandomKey.fromJson(jsonVal['target']);
    this.id = RandomKey.fromJson(jsonVal['id']);
    this.icon = JsonSerializationIconData.fromJson(jsonVal['icon']);
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
