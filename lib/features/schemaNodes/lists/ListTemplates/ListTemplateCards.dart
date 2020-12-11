import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeList.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsCorners.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsShadow.dart';
import 'package:flutter_app/features/schemaNodes/implementations.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListElements.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListTemplates/ListTemplate.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaDoubleProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaIntProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaListItemsProperty.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MyTextField.dart';
import 'package:flutter_app/utils/getThemeColor.dart';

import '../../Functionable.dart';

class ListTemplateCards extends ListTemplate {
  ListTemplateType getType() => ListTemplateType.cards;

  Widget toWidget({
    @required Function onListClick, // should mock it in skeleton
    @required MyTheme theme,
    @required Map<String, SchemaNodeProperty> properties,
    @required bool isSelected,
    SchemaNodeList schemaNodeList,
    bool isPlayMode = false,
  }) {
    return GestureDetector(
      onTap: () {
        onListClick();
      },
      child: Column(
          children: properties['Items']
              .value
              .values
              .map((item) {
                if (isPlayMode) {
                  return GestureDetector(
                    onTap: () {
                      (schemaNodeList.actions['Tap'] as Functionable)
                          .toFunction(schemaNodeList
                              .parentSpawner.userActions)(item.value);
                    },
                    child: widgetFor(
                      item: item,
                      schemaNodeList: schemaNodeList,
                      theme: theme,
                      properties: properties,
                      isSelected: isSelected,
                      isPlayMode: isPlayMode,
                    ),
                  );
                }
                return widgetFor(
                  item: item,
                  schemaNodeList: schemaNodeList,
                  theme: theme,
                  properties: properties,
                  isSelected: isSelected,
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
        // todo: подумать как сделать лучше изменение высота listItem'a
        Row(children: [
          Text(
            'Height',
            style: MyTextStyle.regularCaption,
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: MyTextField(
                defaultValue: properties['ListItemHeight'].value.toString(),
                onChanged: (String value) {
                  changePropertyTo(SchemaDoubleProperty(
                      'ListItemHeight', double.parse(value)));
                }),
          )
        ]),
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

  @override
  Offset padding = Offset(12, 0);

  Widget widgetFor({
    SchemaListItemsProperty item,
    @required MyTheme theme,
    @required Map<String, SchemaNodeProperty> properties,
    @required bool isSelected,
    SchemaNodeList schemaNodeList,
    @required bool isPlayMode,
  }) {
    return Padding(
      padding: EdgeInsets.only(
          top: 11,
          left: this.padding.dx.toDouble(),
          right: this.padding.dx.toDouble()),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: properties['ListItemHeight'].value,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      properties['ItemRadiusValue'].value),
                  color: getThemeColor(
                    theme,
                    properties['ItemColor'],
                  ),
                  boxShadow: properties['BoxShadow'].value
                      ? [
                          BoxShadow(
                            color: getThemeColor(
                              theme,
                              properties['BoxShadowColor'],
                            ).withOpacity(properties['BoxShadowOpacity'].value),
                            blurRadius: properties['BoxShadowBlur'].value,
                            offset: Offset(0.0, 2.0),
                            spreadRadius: 0,
                          )
                        ]
                      : []),
              clipBehavior: Clip.hardEdge,
              child: Stack(
                children: [
                  ...(properties['Elements'].value as ListElements)
                      .listElements
                      .map((ListElementNode el) {
                    Widget renderedWidget;

                    if (el.node is DataContainer && el.columnRelation != null) {
                      final String data =
                          item.value[el.columnRelation]?.data ?? 'no_data';

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
          ),
        ],
      ),
    );
  }
}
