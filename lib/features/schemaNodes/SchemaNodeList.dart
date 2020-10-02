import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListTemplate.dart';
import 'package:flutter_app/features/schemaNodes/schemaAction.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/AppThemeStore.dart';
import 'package:flutter_app/utils/Debouncer.dart';

import 'common/EditPropsColor.dart';
import 'common/EditPropsList.dart';

class SchemaNodeList extends SchemaNode {
  Debouncer<String> textDebouncer;

  SchemaNodeList(
      {Offset position,
      Offset size,
      @required AppThemeStore theme,
      Map<String, SchemaNodeProperty> properties,
      UniqueKey id})
      : super() {
    this.type = SchemaNodeType.list;
    this.position = position ?? Offset(0, 0);
    this.size = size ?? Offset(375.0, 150.0);
    this.id = id ?? UniqueKey();
    this.theme = theme;

    this.actions = actions ?? {'Tap': GoToScreenAction('Tap', null)};
    this.properties = properties ??
        {
          'Items': SchemaStringListProperty('Items', {
            'item1': SchemaListItemProperty(
                'item1', {'Text': SchemaStringProperty("Text", "Item 1")}),
          }),
          'Template': ListTemplate('Template', ListTemplateType.simple),
          'TextColor': SchemaMyThemePropProperty(
              'TextColor', this.theme.currentTheme.general),
        };

    textDebouncer = Debouncer(milliseconds: 500, prevValue: '322');
  }

  @override
  SchemaNode copy(
      {Offset position,
      Offset size,
      UniqueKey id,
      bool saveProperties = true}) {
    return SchemaNodeList(
        position: position ?? this.position,
        id: id ?? this.id,
        size: size ?? this.size,
        properties: saveProperties ? this._copyProperties() : null,
        theme: this.theme);
  }

  Map<String, SchemaNodeProperty> _copyProperties() {
    final newProps = Map<String, SchemaNodeProperty>();
    this.properties.forEach((key, value) {
      newProps[key] = value.copy();
    });

    return newProps;
  }

  @override
  Widget toWidget() {
    final template = this.properties['Template'] as ListTemplate;
    return template.widget(this.properties['Items']);
  }

  @override
  Widget toEditProps(userActions) {
    return Column(children: [
      EditPropsList(
          id: id,
          properties: properties,
          propName: 'Items',
          userActions: userActions,
          textDebouncer: textDebouncer),
      SizedBox(
        height: 10,
      ),
      EditPropsColor(
        theme: theme,
        properties: properties,
        userActions: userActions,
        propName: 'TextColor',
      ),
    ]);
  }
}
