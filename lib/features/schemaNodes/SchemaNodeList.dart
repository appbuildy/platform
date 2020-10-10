import 'package:flutter/material.dart';
import 'package:flutter_app/features/airtable/Client.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsColor.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListElements.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListTemplates/ListTemplate.dart';
import 'package:flutter_app/features/schemaNodes/schemaAction.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/AppThemeStore.dart';
import 'package:flutter_app/ui/ColumnDivider.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MySelects/MyClickSelect.dart';
import 'package:flutter_app/ui/MySelects/MySelects.dart';
import 'package:flutter_app/utils/Debouncer.dart';

class SchemaNodeList extends SchemaNode {
  Debouncer<String> textDebouncer;
  ListTemplateType listTemplateType;

  SchemaNodeList(
      {Offset position,
      Offset size,
      @required AppThemeStore theme,
      @required ListTemplateType listTemplateType,
      Map<String, SchemaNodeProperty> properties,
      UniqueKey id})
      : super() {
    this.type = SchemaNodeType.list;
    this.position = position ?? Offset(0, 0);
    this.size = size ?? Offset(375.0, getListHeightByType(listTemplateType));
    this.id = id ?? UniqueKey();
    this.theme = theme;
    this.listTemplateType = listTemplateType;

    this.actions = actions ?? {'Tap': GoToScreenAction('Tap', null)};
    this.properties = properties ??
        {
          'Table': SchemaStringProperty('Table', null),
          'Items': SchemaStringListProperty.sample(),
          'Template': ListTemplateProperty(
              'Template', getListTemplateByType(listTemplateType)),
          'Elements': ListElementsProperty(
              'Elements',
              ListElements(
                  allColumns: [
                    'restaurant_name',
                    'restaurant_rate',
                    'restaurant_url',
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
          'ItemColor': SchemaMyThemePropProperty(
              'ItemColor', this.theme.currentTheme.background),
          'ItemRadiusValue': SchemaIntProperty('ItemRadiusValue', 8),
          'SeparatorsColor': SchemaMyThemePropProperty(
              'SeparatorsColor', this.theme.currentTheme.separators),
          'BoxShadow': SchemaBoolProperty('BoxShadow', true),
          'BoxShadowColor': SchemaMyThemePropProperty(
              'BoxShadowColor', this.theme.currentTheme.general),
          'BoxShadowBlur': SchemaIntProperty('BoxShadowBlur', 6),
          'BoxShadowOpacity': SchemaDoubleProperty('BoxShadowOpacity', 0.2),
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
      theme: this.theme,
      listTemplateType: this.listTemplateType,
    );
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
    return Container(
      width: this.size.dx,
      height: this.size.dy,
      child: this
          .properties['Template']
          .value
          .toWidget(theme: this.theme, properties: this.properties),
    );
  }

  Future<void> updateData(String tableName, UserActions userActions) async {
    final client = Client.defaultClient(table: tableName);
    print(properties['Items'].value);

    final newProp = await SchemaStringListProperty.fromRemoteTable(client);
    userActions.changePropertyTo(newProp);

    print(properties['Items'].value);
  }

  @override
  Widget toEditProps(UserActions userActions) {
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
                onChange: (screen) async {
                  await updateData(screen.value, userActions);
                  userActions.changePropertyTo(
                      SchemaStringProperty('Table', screen.value));

                  properties['Elements'].value.updateAllColumns(userActions
                      .columnsFor(screen.value)
                      .map((e) => e.name)
                      .toList());
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
      EditPropsColor(
        theme: theme,
        properties: properties,
        propName: 'ItemColor',
        userActions: userActions,
      ),
      this.properties['Template'].value.rowStyle(
          userActions: userActions, properties: properties, theme: theme),
      SizedBox(
        height: 10,
      ),
    ]);
  }
}
