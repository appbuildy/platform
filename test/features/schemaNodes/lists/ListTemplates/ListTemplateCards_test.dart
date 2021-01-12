import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListElements.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListTemplates/ListTemplateCards.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaBoolPropery.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaDoubleProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaIntProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaMyThemePropProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaStringListProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaStringProperty.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var theme = MyThemes.allThemes['blue'];
  Map<String, SchemaNodeProperty> props = {
    "Items": SchemaStringListProperty.sample(),
    'Table': SchemaStringProperty('Table', null),
    'Base': SchemaStringProperty('Base', null),
    'Elements': SchemaListElementsProperty(
      'Elements',
      ListElements(), //ListElements(allColumns: listColumnsSample),
    ),
    'ItemRadiusValue': SchemaDoubleProperty('ItemRadiusValue', 8.0),
    'BoxShadow': SchemaBoolProperty('BoxShadow', true),
    'BoxShadowBlur': SchemaDoubleProperty('BoxShadowBlur', 6.0),
    'BoxShadowOpacity': SchemaDoubleProperty('BoxShadowOpacity', 0.2),
    'ListItemHeight': SchemaDoubleProperty('ListItemHeight', 100),
    'ListItemPadding': SchemaDoubleProperty('ListItemPadding', 0),
    'ListItemsPerRow': SchemaIntProperty('ListItemsPerRow', 1),
    'ItemColor': SchemaMyThemePropProperty('ItemColor', theme.background),
    'BoxShadowColor':
        SchemaMyThemePropProperty('BoxShadowColor', theme.background),
    'BoxShadowOpacity': SchemaDoubleProperty('BoxShadowOpacity', 0.1)
  };

  var list = ListTemplateCards().toWidget(
      onListClick: () => {},
      theme: theme,
      size: Offset(350, 600),
      isSelected: false,
      isPlayMode: true,
      properties: props);

  var app = MaterialApp(title: 'Flutter Demo', home: Scaffold(body: list));

  group('onItemTap', () {
    testWidgets('it executes action on item tap', (WidgetTester tester) async {
      await tester.pumpWidget(app);
    });
  });
}
