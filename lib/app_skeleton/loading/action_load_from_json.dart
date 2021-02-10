import 'package:flutter/cupertino.dart';
import 'package:flutter_app/app_skeleton/entities/action.dart'
    as skeleton_action;
import 'package:flutter_app/app_skeleton/loading/i_action_load.dart';
import 'package:flutter_app/utils/RandomKey.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class ActionLoadFromJson implements IActionLoad {
  Map<String, dynamic> jsonAction;
  Function urlLauncher;
  ActionLoadFromJson(this.jsonAction, [this.urlLauncher = launch]);

  @override
  skeleton_action.Action load() {
    var actionValue = jsonAction.values.first;

    print(actionValue['value']);
    print(actionValue['type'] == 'SchemaActionType.goToScreen');

    Map<String, dynamic> metadata =
        actionValue['type'] == 'SchemaActionType.goToScreen'
            ? {"screenKey": RandomKey.fromJson(actionValue['value'])}
            : {};

    return skeleton_action.Action(jsonAction.keys.first, _loadFunction(),
        metadata: metadata);
  }

  Function _loadFunction() {
    var actionValue = jsonAction.values.first;
    if (actionValue['value'] == null) return _emptyFunction();
    switch (actionValue['type']) {
      case 'SchemaActionType.apiCall':
        {
          var httpClient = http.Client();
          return (BuildContext context) =>
              () => {httpClient.get(actionValue['value'])};
        }
        break;
      case 'SchemaActionType.goToScreen':
        {
          return (BuildContext context) => () =>
              {Navigator.pushNamed(context, actionValue['value']['value'])};
        }
        break;
      case 'SchemaActionType.openLink':
        {
          return (BuildContext context) =>
              () => {urlLauncher(actionValue['value'])};
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
