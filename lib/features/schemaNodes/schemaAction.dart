import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/Functionable.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/utils/RandomKey.dart';

import 'lists/ListItem.dart';

/// action of changing screen
class GoToScreenAction extends SchemaNodeProperty<RandomKey>
    implements Functionable {
  /// routing action
  GoToScreenAction(String name, RandomKey value)
      : this.type = SchemaActionType.goToScreen,
        super(name: name, value: value);

  @override
  Map<String, dynamic> toJson() {
    return {
      'propertyClass': 'GoToScreenAction',
      'action': this.name,
      'type': this.type.toString(),
      'value': this.value == null ? null : this.value.toJson()
    };
  }

  Function toFunction(UserAction userActions) {
    return ([Map<String, ListItem> rowData]) {
      if (rowData != null) {
        var goToScreen = userActions.screens.all.screens
            .where((screen) => screen.id == this.value)
            .first;

        print('row data is not null,  $rowData');
        print('go to screen,  $rowData');
        if (goToScreen.detailedInfo != null) {
          goToScreen.detailedInfo.rowData = rowData;
          goToScreen.setDetailedInfo(goToScreen.detailedInfo);
        }
        goToScreen.components.toList().forEach((dynamic component) {
          if (component.properties['Column'] != null &&
              component.properties['Column'].value != null) {
            Future.value(() {
              userActions.selectNodeForEdit(
                component,
              );
              // TODO refac из-за того что в changePropertyTo нельзя прокинуть
              // редактируемую ноду, надо выбирать текущий скрин
              component.updateOnColumnDataChange(
                userActions,
                rowData[component.properties['Column'].value].data,
              );
            });
          }
        });
        Future.delayed(Duration(milliseconds: 50), () {
          userActions.screens.selectById(this.value);
          userActions.selectNodeForEdit(null);
        });
      } else {
        userActions.screens.selectById(this.value);
      }
    };
  }

  @override
  GoToScreenAction copy() {
    return GoToScreenAction(this.name, value);
  }

  @override
  SchemaActionType type;

  GoToScreenAction.fromJson(Map<String, dynamic> jsonVal)
      : type = SchemaActionType.goToScreen,
        super(
          name: 'Prop',
          value: RandomKey.fromJson(jsonVal['value']),
        );
}
