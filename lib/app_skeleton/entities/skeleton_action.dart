import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

typedef _SkeletonActionCallback = Function(BuildContext context);

class SkeletonAction {
  final String name;
  final _SkeletonActionCallback onLaunch;

  const SkeletonAction({this.name, this.onLaunch});

  // @override
  // factory fromJson {
  //   return skeleton_action.SkeletonAction(jsonAction.keys.first, _loadFunction());
  // }

  // Function _loadFunction() {
  //   var actionValue = jsonAction.values.first;
  //   if (actionValue['value'] == null) return _emptyFunction();
  //   switch (actionValue['type']) {

  //     default:
  //       {
  //         return _emptyFunction();
  //       }
  //   }
  // }

  // _emptyFunction() {
  //   return (BuildContext context) => () => {};
  // }

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
