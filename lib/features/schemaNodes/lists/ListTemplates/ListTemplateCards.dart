import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListElements.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListItem.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListTemplates/ListTemplate.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/AppThemeStore.dart';
import 'package:flutter_app/ui/MyColors.dart';

class ListTemplateCards extends ListTemplate {
  Widget widget(
      {SchemaStringListProperty items,
      ListElementsProperty elements,
      AppThemeStore theme}) {
    return Column(
        children: items.value.values
            .map((item) {
              return widgetFor(
                  item: item, elements: elements.value, theme: theme);
            })
            .toList()
            .cast<Widget>());
  }

  Widget widgetFor(
      {SchemaListItemProperty item,
      ListElements elements,
      AppThemeStore theme}) {
    return Padding(
      padding: const EdgeInsets.only(top: 11, left: 12, right: 12),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: MyColors.white,
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
                            topLeft: Radius.circular(9),
                            topRight: Radius.circular(9),
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
