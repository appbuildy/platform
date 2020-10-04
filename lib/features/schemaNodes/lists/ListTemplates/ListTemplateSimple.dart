import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListElements.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListItem.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListTemplates/ListTemplate.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/AppThemeStore.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListTemplateSimple extends ListTemplate {
  Widget widget(
      {SchemaStringListProperty items,
      ListElementsProperty elements,
      AppThemeStore theme}) {
    print('hey bitch im listTemplate');
    print('items ${items.value.values.first.value}');
    print(
        'column ${(items.value.values.first.value['Name'] != null ? items.value.values.first.value['Name'].column : 'kek')}');
    print(
        'data ${(items.value.values.first.value['Name'] != null ? items.value.values.first.value['Name'].data : 'kek')}');
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
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 1, color: theme.currentTheme.separators.color))),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 24.0, right: 24.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  elements.image != null
                      ? Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                              item.value[elements.image.column]?.data ?? '',
                              fit: BoxFit.cover,
                              width: 36,
                              height: 36,
                            ),
                          ),
                        )
                      : Container(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      elements.title != null
                          ? Text(
                              item.value[elements.title.column]?.data ?? '',
                              style: MyTextStyle.regularTitle,
                            )
                          : Container(),
                      elements.subtitle != null
                          ? Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                item.value[elements.subtitle.column]?.data ??
                                    '',
                                style: MyTextStyle.regularCaption,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  elements.navigationIcon != null
                      ? Expanded(
                          child: Container(),
                        )
                      : Container(),
                  elements.navigationIcon != null
                      ? FaIcon(
                          FontAwesomeIcons.chevronRight,
                          color: theme.currentTheme.separators.color,
                          size: 18,
                        )
                      : Container()
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
