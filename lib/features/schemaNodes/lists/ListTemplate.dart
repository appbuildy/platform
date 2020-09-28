import 'package:flutter/cupertino.dart';

import '../SchemaNodeProperty.dart';

enum ListTemplateType { simple, WithPhoto }

class ListTemplate extends SchemaNodeProperty<ListTemplateType> {
  ListTemplateType type;

  ListTemplate(String name, ListTemplateType value) : super(name, value);

  Widget widget(
    Map<String, SchemaNodeProperty> properties,
  ) {
    return Column(
        children: properties['Items']
            .value
            .values
            .map((item) {
              return Text(
                item.value,
                style: TextStyle(fontSize: 16.0),
              );
            })
            .toList()
            .cast<Widget>());
  }

  @override
  ListTemplate copy() {
    return ListTemplate(this.name, value);
  }
}
