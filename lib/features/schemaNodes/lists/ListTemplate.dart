import 'package:flutter/cupertino.dart';

import '../SchemaNodeProperty.dart';

enum ListTemplateType { simple, WithPhoto }

class ListTemplate {
  ListTemplateType type;

  ListTemplate(this.type);

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
                style: TextStyle(
                    fontSize: 16.0,
                    color: getThemeColor(theme, properties['TextColor'])),
              );
            })
            .toList()
            .cast<Widget>());
  }
}
