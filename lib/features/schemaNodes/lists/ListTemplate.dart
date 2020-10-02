import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/lists/DefaultListItem.dart';

import '../SchemaNodeProperty.dart';

enum ListTemplateType { simple, WithPhoto }

class ListTemplate extends SchemaNodeProperty<ListTemplateType> {
  ListTemplateType type;

  ListTemplate(String name, ListTemplateType value) : super(name, value);

  Widget editProps(UserActions userActions) {
//    final textDebouncer = Debouncer(milliseconds: 500, prevValue: '322');
    return Column(children: [
//      EditPropsList(
//          id: id,
//          properties: properties,
//          propName: 'Items',
//          userActions: userActions,
//          textDebouncer: textDebouncer),
      SizedBox(
        height: 10,
      ),
//      EditPropsColor(
//        theme: theme,
//        properties: properties,
//        userActions: userActions,
//        propName: 'TextColor',
//      ),
    ]);
  }

  Widget widget(SchemaStringListProperty items) {
    return Column(
        children: items.value.values
            .map((item) {
              return _widgetFor(item);
            })
            .toList()
            .cast<Widget>());
  }

  Widget _widgetFor(SchemaListItemProperty item) {
    final Map<ListTemplateType, Widget> mappings = Map();
    mappings[ListTemplateType.simple] =
        DefaultListItem(text: item.value['Text']).renderWidget();

    return mappings[this.value];
  }

  @override
  ListTemplate copy() {
    return ListTemplate(this.name, value);
  }
}
