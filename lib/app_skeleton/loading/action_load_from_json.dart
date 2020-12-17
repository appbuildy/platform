import 'package:flutter/cupertino.dart';
import 'package:flutter_app/app_skeleton/entities/sk_action.dart';
import 'package:flutter_app/app_skeleton/loading/i_loader.dart';

class ActionLoadFromJson implements ILoader<SkAction> {
  Map<String, dynamic> jsonAction;
  ActionLoadFromJson(this.jsonAction);

  @override
  SkAction load() {
    return SkAction(jsonAction.keys.first, _loadFunction());
  }

  Function _loadFunction() {
    var actionValue = jsonAction.values.first;
    if (actionValue['value'] == null) return _emptyFunction();
    switch (actionValue['type']) {
      case 'SchemaActionType.goToScreen':
        {
          return (BuildContext context) => () =>
              {Navigator.pushNamed(context, actionValue['value']['value'])};
        }
        break;
      default:
        {
          return _emptyFunction();
        }
    }
  }

  _emptyFunction() {
    return (BuildContext context) => () => {};
  }
}
