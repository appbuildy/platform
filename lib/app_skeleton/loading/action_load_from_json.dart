import 'package:flutter/cupertino.dart';
import 'package:flutter_app/app_skeleton/entities/action.dart'
    as skeleton_action;
import 'package:flutter_app/app_skeleton/loading/i_action_load.dart';

class ActionLoadFromJson implements IActionLoad {
  Map<String, dynamic> jsonAction;
  ActionLoadFromJson(this.jsonAction);

  @override
  skeleton_action.Action load() {
    return skeleton_action.Action(jsonAction.keys.first, _loadFunction());
  }

  Function _loadFunction() {
    var actionValue = jsonAction.values.first;
    switch (actionValue['type']) {
      case 'SchemaActionType.goToScreen':
        {
          return (BuildContext context) => () =>
              {Navigator.pushNamed(context, actionValue['value']['value'])};
        }
        break;
      default:
        {
          return () => {};
        }
    }
  }
}
