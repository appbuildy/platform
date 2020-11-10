import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/Functionable.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsCorners.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsShadow.dart';
import 'package:flutter_app/features/schemaNodes/implementations.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListElements.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListTemplates/ListTemplate.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaIntProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaListItemsProperty.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_app/utils/getThemeColor.dart';

class ListTemplateCards extends ListTemplate {
  ListTemplateType getType() => ListTemplateType.cards;

  Widget toWidget({
    MyTheme currentTheme,
    Map<String, SchemaNodeProperty> properties,
    Map<String, SchemaNodeProperty> actions,
    UserActions userActions,
    bool isPlayMode = false,
  }) {
    return Column(
        children: properties['Items']
            .value
            .values
            .map((item) {
              if (isPlayMode) {
                return GestureDetector(
                  onTap: () {
                      (actions['Tap'] as Functionable)
                          .toFunction(userActions)(item.value);
                  },
                  child: widgetFor(
                      item: item,
                      elements: properties['Elements'].value,
                      currentTheme: currentTheme,
                      properties: properties),
                );
              }
              return widgetFor(
                  item: item,
                  elements: properties['Elements'].value,
                  currentTheme: currentTheme,
                  properties: properties);
            })
            .toList()
            .cast<Widget>());
  }

  Widget rowStyle({
    Map<String, SchemaNodeProperty> properties,
    Function(SchemaNodeProperty, [bool, dynamic]) changePropertyTo,
    MyTheme currentTheme,
  }) {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        EditPropsCorners(
          value: properties['ItemRadiusValue'].value,
          onChanged: (int value) {
            changePropertyTo(SchemaIntProperty('ItemRadiusValue', value));
          },
        ),
        SizedBox(
          height: 15,
        ),
        EditPropsShadow(
          properties: properties,
          changePropertyTo: changePropertyTo,
          currentTheme: currentTheme,
        )
      ],
    );
  }

  Widget widgetFor({
    SchemaListItemsProperty item,
    ListElements elements,
    MyTheme currentTheme,
    Map<String, SchemaNodeProperty> properties,
    bool isPlayMode
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 11, left: 12, right: 12),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      properties['ItemRadiusValue'].value),
                  color: getThemeColor(
                    currentTheme,
                    properties['ItemColor'],
                  ),
                  boxShadow: properties['BoxShadow'].value
                      ? [
                          BoxShadow(
                              color: getThemeColor(currentTheme,
                                      properties['BoxShadowColor'])
                                  .withOpacity(
                                      properties['BoxShadowOpacity'].value),
                              blurRadius: properties['BoxShadowBlur'].value,
                              offset: Offset(0.0, 2.0),
                              spreadRadius: 0)
                        ]
                      : []),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...elements.listElements.map((ListElementNode el) {
                    if (el.node is DataContainer && el.columnRelation != null) {
                      final String data = item.value[el.columnRelation]?.data;
                      return (el.node as DataContainer).toWidgetWithReplacedData(data: data);
                    }
                    return el.node.toWidget();
                  })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
