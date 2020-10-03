import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListElements.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListTemplate.dart';
import 'package:flutter_app/features/schemaNodes/schemaAction.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/AppThemeStore.dart';
import 'package:flutter_app/ui/ColumnDivider.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MySelects/MyClickSelect.dart';
import 'package:flutter_app/ui/MySelects/MySelects.dart';
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
          'Table': SchemaStringProperty('Table', null),
          'Items': SchemaStringListProperty('Items', {
            // пример дата айтемов-row с сгенеренными
            'mac': SchemaListItemProperty('mac', {
              'restaurant_name':
                  ListItem(column: 'restaurant_name', data: 'McDonalds'),
              'restaurant_rate':
                  ListItem(column: 'restaurant_rate', data: 'Fast Food'),
              'restaurant_url': ListItem(
                  column: 'restaurant_url',
                  data:
                      'https://images.unsplash.com/photo-1552895638-f7fe08d2f7d5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=256&q=80'),
            }),
            'bk': SchemaListItemProperty('mac', {
              'restaurant_name':
                  ListItem(column: 'restaurant_name', data: 'Burger King'),
              'restaurant_rate':
                  ListItem(column: 'restaurant_rate', data: 'Fast Food'),
              'restaurant_url': ListItem(
                  column: 'restaurant_url',
                  data:
                      'https://images.unsplash.com/photo-1528669826296-dbd6f641707d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=256&q=80'),
            }),
            'lucky': SchemaListItemProperty('lucky', {
              'restaurant_name':
                  ListItem(column: 'restaurant_name', data: 'Lucky In The Kai'),
              'restaurant_rate':
                  ListItem(column: 'restaurant_rate', data: 'Elite Restaurant'),
              'restaurant_url': ListItem(
                  column: 'restaurant_url',
                  data:
                      'https://images.unsplash.com/photo-1579065693224-0a3abed6a058?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=256&q=80'),
            }),
          }),
          'Template': ListTemplate('Template', ListTemplateType.simple),
          'Elements': ListElementsProperty(
              'Elements',
              ListElements(
                  allColumns: [
                    'restaurant_name',
                    'restaurant_rate',
                    'restaurant_url',
                    'restaurant_kek'
                  ],
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
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: MyClickSelect(
                placeholder: 'Select Table',
                selectedValue: properties['Table'].value ?? null,
                onChange: (screen) {
                  userActions.changePropertyTo(
                      SchemaStringProperty('Table', screen.value));
                },
                options: userActions.tables
                    .map((element) => SelectOption(element, element))
                    .toList()),
          )
        ],
      ),
      ColumnDivider(
        name: 'Row Elements',
      ),
      (properties['Elements'].value as ListElements).toEditProps(userActions),
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
