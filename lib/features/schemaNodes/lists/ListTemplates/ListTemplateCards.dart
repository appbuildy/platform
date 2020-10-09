import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsCorners.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListElements.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListItem.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListTemplates/ListTemplate.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/AppThemeStore.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/utils/getThemeColor.dart';

class ListTemplateCards extends ListTemplate {
  Widget toWidget(
      {AppThemeStore theme, Map<String, SchemaNodeProperty> properties}) {
    return Column(
        children: properties['Items']
            .value
            .values
            .map((item) {
              return widgetFor(
                  item: item,
                  elements: properties['Elements'].value,
                  theme: theme,
                  properties: properties);
            })
            .toList()
            .cast<Widget>());
  }

  Widget rowStyle({
    Map<String, SchemaNodeProperty> properties,
    UserActions userActions,
    AppThemeStore theme,
  }) {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        EditPropsCorners(
          value: properties['ItemRadiusValue'].value,
          onChanged: (int value) {
            userActions
                .changePropertyTo(SchemaIntProperty('ItemRadiusValue', value));
          },
        )
      ],
    );
  }

  Widget widgetFor(
      {SchemaListItemProperty item,
      ListElements elements,
      AppThemeStore theme,
      Map<String, SchemaNodeProperty> properties}) {
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
                    theme,
                    properties['ItemColor'],
                  ),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 0,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                        color: MyColors.black.withOpacity(0.2))
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  elements.image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                                properties['ItemRadiusValue'].value),
                            topRight: Radius.circular(
                                properties['ItemRadiusValue'].value),
                          ),
                          child: Image.network(
                            item.value[elements.image.column]?.data ?? '',
                            fit: BoxFit.cover,
                            height: 80,
                            width: 351,
                          ),
                        )
                      : Container(),
                  elements.title != null
                      ? Padding(
                          padding: EdgeInsets.only(
                              left: 13,
                              right: 13,
                              top: 11.0,
                              bottom: elements.subtitle != null ? 0 : 12),
                          child: Text(
                            item.value[elements.title.column]?.data ?? '',
                            style: MyTextStyle.regularTitle,
                          ),
                        )
                      : Container(),
                  elements.subtitle != null
                      ? Padding(
                          padding: const EdgeInsets.only(
                              left: 13, right: 13, top: 3, bottom: 12),
                          child: Text(
                            item.value[elements.subtitle.column]?.data ?? '',
                            style: MyTextStyle.regularCaption,
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
