import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/Functionable.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsColor.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListElements.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListTemplates/ListTemplate.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaListItemsProperty.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/utils/getThemeColor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListTemplateSimple extends ListTemplate {
  ListTemplateType getType() => ListTemplateType.simple;

  Widget toWidget(
      {MyTheme currentTheme,
      Map<String, SchemaNodeProperty> properties,
      Map<String, SchemaNodeProperty> actions,
      UserActions userActions,
      bool isPlayMode = false}) {
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

  Widget rowStyle(
      {Map<String, SchemaNodeProperty> properties,
      UserActions userActions,
      MyTheme currentTheme}) {
    return Column(children: [
      SizedBox(
        height: 15,
      ),
      EditPropsColor(
          title: 'Separators',
          currentTheme: currentTheme,
          userActions: userActions,
          propName: 'SeparatorsColor',
          properties: properties)
    ]);
  }

  Widget widgetFor(
      {SchemaListItemsProperty item,
      ListElements elements,
      MyTheme currentTheme,
      Map<String, SchemaNodeProperty> properties}) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: getThemeColor(
                  currentTheme,
                  properties['ItemColor'],
                ),
                border: Border(
                    bottom: BorderSide(
                        width: 1,
                        color: getThemeColor(
                          currentTheme,
                          properties['SeparatorsColor'],
                        )))),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 24.0, right: 24.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ...elements.listElements.map((ListElementNode el) => el.buildWidget())
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
