import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListElements.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListTemplate.dart';
import 'package:flutter_app/features/schemaNodes/schemaAction.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/AppThemeStore.dart';
import 'package:flutter_app/ui/ColumnDivider.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/utils/Debouncer.dart';

import 'lists/ListItem.dart';

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
    this.size = size ?? Offset(375.0, 250.0);
    this.id = id ?? UniqueKey();
    this.theme = theme;

    this.actions = actions ?? {'Tap': GoToScreenAction('Tap', null)};
    this.properties = properties ??
        {
          'Items': SchemaStringListProperty('Items', {
            // пример дата айтемов-row с сгенеренными
            'mac': SchemaListItemProperty('mac', {
              'restaurant_name':
                  ListItem(column: 'restaurant_name', data: 'McDonalds'),
              'restaurant_rate':
                  ListItem(column: 'restaurant_rate', data: 'Fast Food'),
              'restaurant_url':
                  ListItem(column: 'restaurant_url', data: 'http://google.com'),
            }),
            'bk': SchemaListItemProperty('mac', {
              'restaurant_name':
                  ListItem(column: 'restaurant_name', data: 'Burger King'),
              'restaurant_rate':
                  ListItem(column: 'restaurant_rate', data: 'Fast Food'),
              'restaurant_url':
                  ListItem(column: 'restaurant_url', data: 'http://google.com'),
            }),
            'lucky': SchemaListItemProperty('lucky', {
              'restaurant_name':
                  ListItem(column: 'restaurant_name', data: 'Lucky In The Kai'),
              'restaurant_rate':
                  ListItem(column: 'restaurant_rate', data: 'Elite Restaurant'),
              'restaurant_url':
                  ListItem(column: 'restaurant_url', data: 'http://google.com'),
            }),
          }),
          'Template': ListTemplate('Template', ListTemplateType.simple),
          'Elements': ListElementsProperty(
              'Elements',
              ListElements(
                  title: ListElement(
                      type: ListElementType.title, column: 'restaurant_name'),
                  subtitle: ListElement(
                      type: ListElementType.subtitle,
                      column: 'restaurant_rate'),
                  image: ListElement(
                      type: ListElementType.image, column: 'restaurant_url'),
                  navigationIcon: ListElement(
                      type: ListElementType.navigationIcon, column: 'true'))),
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
    return Container(
      width: this.size.dx,
      height: this.size.dy,
      child: template.widget(
          items: this.properties['Items'],
          elements: this.properties['Elements'],
          theme: this.theme),
    );
  }

  @override
  Widget toEditProps(userActions) {
    return Column(children: [
      ColumnDivider(
        name: 'Data Source',
      ),
      Row(
        children: [
          Text(
            'Table from',
            style: MyTextStyle.regularCaption,
          )
        ],
      ),
      ColumnDivider(
        name: 'Row Elements',
      ),
      properties['Elements'].value.toEditProps(),
      ColumnDivider(
        name: 'Row Style',
      ),
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
}
