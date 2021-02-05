import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/Functionable.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MySelects/MyClickSelect.dart';
import 'package:flutter_app/ui/MySelects/MySelects.dart';
import 'package:flutter_app/utils/RandomKey.dart';

import 'lists/ListItem.dart';

class GoToScreenAction extends SchemaNodeProperty<RandomKey>
    implements Functionable {
  GoToScreenAction(String name, RandomKey value) : super(name, value) {
    this.type = SchemaActionType.goToScreen;
    this.name = name;
    this.value = value;
    this.column = null;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'propertyClass': 'GoToScreenAction',
      'action': this.name,
      'type': this.type.toString(),
      'value': this.value == null ? null : this.value.toJson(),
      'column': this.column,
    };
  }

  GoToScreenAction.fromJson(Map<String, dynamic> jsonVal)
      : super('Prop', null) {
    this.name = jsonVal['action'];
    this.type = SchemaActionType.goToScreen;
    this.value = RandomKey.fromJson(jsonVal['value']);
    this.column = jsonVal['column'];
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
              (component as dynamic).updateOnColumnDataChange(
                  rowData[component.properties['Column'].value].data);
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

  @override
  String column;

  @override
  Widget toEditProps(UserActions userActions) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Navigate to',
              style: MyTextStyle.regularCaption,
            ),
            Container(
              width: 170,
              child: MyClickSelect(
                  placeholder: 'Select Page',
                  selectedValue:
                      userActions.selectedNode().actions['Tap'].value ?? null,
                  onChange: (screen) {
                    print(screen.value.toString());
                    userActions
                        .changeActionTo(GoToScreenAction('Tap', screen.value));
                  },
                  options: userActions.screens.all.screens
                      .map((element) => SelectOption(element.name, element.id))
                      .toList()),
            )
          ],
        )
      ],
    );
  }
}
