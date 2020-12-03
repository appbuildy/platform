import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/Functionable.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsColor.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListElements.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListTemplates/ListTemplate.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaDoubleProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaListItemsProperty.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MyTextField.dart';
import 'package:flutter_app/utils/getThemeColor.dart';

import 'package:flutter_app/features/schemaNodes/SchemaNodeList.dart';
import 'package:flutter_app/features/schemaNodes/implementations.dart';

class ListTemplateSimple extends ListTemplate {
  ListTemplateType getType() => ListTemplateType.simple;

  Widget toWidget({
    @required SchemaNodeList schemaNodeList,
    bool isPlayMode = false,
  }) {
    return GestureDetector(
      onTap: () {
        print('ListTemplateSimple');
        schemaNodeList.onListClick();
      },
      child: Column(
          children: schemaNodeList.properties['Items']
              .value
              .values
              .map((item) {
                if (isPlayMode) {
                  return GestureDetector(
                    onTap: () {
                      (schemaNodeList.actions['Tap'] as Functionable)
                          .toFunction(schemaNodeList.parentSpawner.userActions)(item.value);
                    },
                    child: widgetFor(
                      item: item,
                      schemaNodeList: schemaNodeList,
                      isPlayMode: isPlayMode,
                    ),
                  );
                }
                return widgetFor(
                  item: item,
                  schemaNodeList: schemaNodeList,
                  isPlayMode: isPlayMode,
                );
              })
              .toList()
              .cast<Widget>()),
    );
  }

  Widget rowStyle({
    Map<String, SchemaNodeProperty> properties,
    Function(SchemaNodeProperty, [bool, dynamic]) changePropertyTo,
    MyTheme currentTheme,
  }) {
    return Column(children: [
      SizedBox(
        height: 15,
      ),
      EditPropsColor(
        title: 'Separators',
        currentTheme: currentTheme,
        changePropertyTo: changePropertyTo,
        propName: 'SeparatorsColor',
        properties: properties,
      ),
      SizedBox(
        height: 15,
      ),
      // todo: подумать как сделать лучше изменение высота listItem'a
      Row(
          children: [
            Text(
              'Высота',
              style: MyTextStyle.regularCaption,
            ),
            SizedBox(
              width: 13,
            ),
            Expanded(
              child: MyTextField(
                  defaultValue: properties['ListItemHeight'].value.toString(),
                  onChanged: (String value) {
                    changePropertyTo(SchemaDoubleProperty('ListItemHeight', double.parse(value)));
                  }
              ),
            )
          ]
      ),
    ]);
  }

  Widget widgetFor({
    @required SchemaListItemsProperty item,
    @required SchemaNodeList schemaNodeList,
    @required bool isPlayMode,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Container(
                height: schemaNodeList.properties['ListItemHeight'].value,
                decoration: BoxDecoration(
                  color: getThemeColor(
                    schemaNodeList.parentSpawner.userActions.currentTheme,
                    schemaNodeList.properties['ItemColor'],
                  ),
                ),
                child: Stack(
                  children: [
                    ...(schemaNodeList.properties['Elements'].value as ListElements).listElements.map((ListElementNode el) {
                      Widget renderedWidget;

                      if (el.node is DataContainer && el.columnRelation != null) {
                        final String data = item.value[el.columnRelation]?.data ?? 'no_data';

                        renderedWidget = el.toWidgetWithReplacedData(
                          data: data,
                          schemaNodeList: schemaNodeList,
                          isPlayMode: isPlayMode,
                        );
                      } else {
                        renderedWidget = el.toWidget(
                          schemaNodeList: schemaNodeList,
                          isPlayMode: isPlayMode,
                        );
                      }

                      return Positioned(
                        top: el.node.position.dy,
                        left: el.node.position.dx,
                        child: renderedWidget,
                      );
                    })
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: getThemeColor(
                        schemaNodeList.parentSpawner.userActions.currentTheme,
                        schemaNodeList.properties['SeparatorsColor'],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
