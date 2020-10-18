import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/Functionable.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/utils/RandomKey.dart';

import 'JsonConvertable.dart';
import 'lists/ListItem.dart';

class GoToScreenAction extends SchemaNodeProperty<RandomKey>
    implements Functionable, JsonConvertable {
  GoToScreenAction(String name, RandomKey value) : super(name, value) {
    this.type = SchemaActionType.goToScreen;
    this.name = name;
    this.value = value;
  }

  Function toFunction(UserActions userActions) {
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
        goToScreen.components.toList().forEach((component) {
          if (component.properties['Column'] != null &&
              component.properties['Column'].value != null) {
            Future.delayed(Duration(milliseconds: 0), () {
              userActions.selectNodeForEdit(
                  component); // TODO refac из-за того что в changePropertyTo нельзя прокинуть редактируемую ноду, надо выбирать текущий скрин
              (component as dynamic).updateOnColumnDataChange(userActions,
                  rowData[component.properties['Column'].value].data);
              userActions.selectNodeForEdit(null);
            });
          }
        });
        Future.delayed(Duration(milliseconds: 50), () {
          userActions.screens.selectById(this.value);
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

  @override
  Map<String, dynamic> toJson() {
    return {
      'action': this.name,
      'type': this.type.toString(),
      'value': this.value
    };
  }
}

class MyDoNothingAction extends SchemaNodeProperty implements Functionable {
  MyDoNothingAction() : super('', 'myDoNothingAction') {
    this.type = SchemaActionType.doNothing;
  }

  Function toFunction(UserActions userActions) {
    return () {};
  }

  @override
  SchemaNodeProperty copy() {
    return MyDoNothingAction();
  }

  @override
  SchemaActionType type;
}
