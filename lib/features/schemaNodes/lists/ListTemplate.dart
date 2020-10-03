import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListElements.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListItem.dart';
import 'package:flutter_app/ui/MyColors.dart';

import '../SchemaNodeProperty.dart';

enum ListTemplateType { simple, WithPhoto }

class ListTemplate extends SchemaNodeProperty<ListTemplateType> {
  ListTemplateType type;

  ListTemplate(String name, ListTemplateType value) : super(name, value);

  Widget widget(SchemaStringListProperty items, ListElementsProperty elements) {
    return Column(
        children: items.value.values
            .map((item) {
              return _widgetFor(item, elements.value);
            })
            .toList()
            .cast<Widget>());
  }

  Widget _widgetFor(SchemaListItemProperty item, ListElements elements) {
//    final Map<ListTemplateType, Widget> mappings = Map();

    return Column(
      children: [
        elements.title != null
            ? Text(
                item.value[elements.title.column].data,
                style: MyTextStyle.regularTitle,
              )
            : Container(),
        elements.subtitle != null
            ? Text(
                item.value[elements.subtitle.column].data,
                style: MyTextStyle.regularCaption,
              )
            : Container()
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
