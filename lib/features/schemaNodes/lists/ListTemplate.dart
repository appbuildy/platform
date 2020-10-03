import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListElements.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListItem.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/AppThemeStore.dart';
import 'package:flutter_app/ui/MyColors.dart';

import '../SchemaNodeProperty.dart';

enum ListTemplateType { simple, WithPhoto }

class ListTemplate extends SchemaNodeProperty<ListTemplateType> {
  ListTemplateType type;

  ListTemplate(String name, ListTemplateType value) : super(name, value);

  Widget widget(
      {SchemaStringListProperty items,
      ListElementsProperty elements,
      AppThemeStore theme}) {
    return Column(
        children: items.value.values
            .map((item) {
              return _widgetFor(item, elements.value, theme);
            })
            .toList()
            .cast<Widget>());
  }

  Widget _widgetFor(
      SchemaListItemProperty item, ListElements elements, AppThemeStore theme) {
//    final Map<ListTemplateType, Widget> mappings = Map();

    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 1, color: theme.currentTheme.separators.color))),
            child: Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  elements.title != null
                      ? Text(
                          item.value[elements.title.column].data,
                          style: MyTextStyle.regularTitle,
                        )
                      : Container(),
                  elements.subtitle != null
                      ? Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            item.value[elements.subtitle.column].data,
                            style: MyTextStyle.regularCaption,
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );

//    mappings[ListTemplateType.simple] =
//        DefaultListItem(text: item.value['Text']).renderWidget();

//    return mappings[this.value];

    return Container();
  }

  @override
  ListTemplate copy() {
    return ListTemplate(this.name, value);
  }
}
