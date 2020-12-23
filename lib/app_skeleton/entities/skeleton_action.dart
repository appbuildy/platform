import 'dart:convert';

import 'package:flutter/widgets.dart';

typedef _SkeletonActionCallback = Function(BuildContext context);

///
class SkeletonAction {
  final String name;
  final _SkeletonActionCallback onLaunch;

  const SkeletonAction({this.name, this.onLaunch});

  factory SkeletonAction.fromMap(Map<String, dynamic> map) {
    final dynamic action = map?.values?.first;
    final bool isValid = action != null &&
        action is Map<String, dynamic> &&
        action['value'] != null;

    if (!isValid) return null;
    switch (action['value']['type']) {
      case 'SchemaActionType.goToScreen':
        {
          return SkeletonAction(
            name: action['action'],
            onLaunch: (BuildContext context) => Navigator.pushNamed(
              context,
              action['value']['value']['value'],
            ),
          );
        }
      default:
        return SkeletonAction(
          name: 'Empty',
          onLaunch: (_) {},
        );
    }
  }

  factory SkeletonAction.fromJson(String source) =>
      SkeletonAction.fromMap(json.decode(source));
}
