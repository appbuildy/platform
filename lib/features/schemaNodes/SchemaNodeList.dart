import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/schemaAction.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/AppThemeStore.dart';
import 'package:flutter_app/utils/Debouncer.dart';
import 'package:flutter_app/utils/getThemeColor.dart';

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
    this.size = size ?? Offset(150.0, 100.0);
    this.id = id ?? UniqueKey();
    this.theme = theme;

    this.actions = actions ?? {'Tap': GoToScreenAction('Tap', null)};
    this.properties = properties ??
        {
          'Items': SchemaStringListProperty('Items', {
            'item1': SchemaStringProperty('item1', 'Item 1'),
            'item2': SchemaStringProperty('item2', 'Item 2')
          }),
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
