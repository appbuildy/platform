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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../SchemaNodeList.dart';
import '../../implementations.dart';

class ListTemplateSimple extends ListTemplate {
  ListTemplateType getType() => ListTemplateType.simple;

  Widget toWidget({
    @required SchemaNodeList schemaNodeList,
    // MyTheme currentTheme,
    // Map<String, SchemaNodeProperty> properties,
    // Map<String, SchemaNodeProperty> actions,
    // UserActions userActions,
    bool isPlayMode = false,
  }) {
    return Column(
        children: schemaNodeList.properties['Items']
            .value
            .values
            .map((item) {
              if (isPlayMode) {
                return GestureDetector(
                  onTap: () {
                    (schemaNodeList.actions['Tap'] as Functionable)
                        .toFunction(schemaNodeList.parent.userActions)(item.value);
                  },
                  child: widgetFor(
                    item: item,
                    schemaNodeList: schemaNodeList,
                    isPlayMode: isPlayMode,
                    //isPlayMode: isPlayMode,
                    // elements: properties['Elements'].value,
                    // currentTheme: currentTheme,
                    // properties: properties,
                  ),
                );
              }
              return widgetFor(
                item: item,
                schemaNodeList: schemaNodeList,
                isPlayMode: isPlayMode,
                //isPlayMode: isPlayMode,
                // elements: properties['Elements'].value,
                // currentTheme: currentTheme,
                // properties: properties,
              );
            })
            .toList()
            .cast<Widget>());
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
      // todo: style this sh
      MyTextField(
        defaultValue: properties['ListItemHeight'].value.toString(),
        onChanged: (String value) {
          changePropertyTo(SchemaDoubleProperty('ListItemHeight', double.parse(value)));
        }
      ),
    ]);
  }

  Widget widgetFor({
    @required SchemaListItemsProperty item,
    @required SchemaNodeList schemaNodeList,
    @required bool isPlayMode,
    // ListElements elements,
    // MyTheme currentTheme,
    // Map<String, SchemaNodeProperty> properties
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
                    schemaNodeList.parent.userActions.currentTheme,
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
                          padding: Offset(0, 0),
                        );
                      } else {
                        renderedWidget = el.toWidget(
                          schemaNodeList: schemaNodeList,
                          isPlayMode: isPlayMode,
                          padding: Offset(0, 0),
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
                        schemaNodeList.parent.userActions.currentTheme,
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
