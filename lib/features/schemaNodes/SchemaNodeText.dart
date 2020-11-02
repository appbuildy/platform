import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeSpawner.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsFontStyle.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaCrossAlignmentProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaFontWeightProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaIntProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaMainAlignmentProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaMyThemePropProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaStringProperty.dart';
import 'package:flutter_app/features/schemaNodes/schemaAction.dart';
import 'package:flutter_app/shared_widgets/text.dart' as Shared;
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_app/ui/ColumnDivider.dart';
import 'package:flutter_app/utils/Debouncer.dart';

import 'common/EditPropsText.dart';

class SchemaNodeText extends SchemaNode {
  Debouncer<String> textDebouncer;

  SchemaNodeText({
    @required SchemaNodeSpawner parent,
    UniqueKey id,
    Offset position,
    Offset size,
    Map<String, SchemaNodeProperty> properties,
    Map<String, SchemaNodeProperty> actions,
    String column,
    String text,
    MyThemeProp color,
    int fontSize,
    FontWeight fontWeight,
  }) : super() {
    this.parent = parent;
    this.type = SchemaNodeType.text;
    this.position = position ?? Offset(0, 0);
    this.size = size ?? Offset(343.0, 50.0);
    this.id = id ?? UniqueKey();
    this.actions = actions ?? {'Tap': GoToScreenAction('Tap', null)};
    this.properties = properties ??
        {
          'Text': SchemaStringProperty('Text', text ?? 'Text'),
          'FontColor': SchemaMyThemePropProperty(
              'FontColor', color ?? parent.userActions.themeStore.currentTheme.general),
          'FontSize': SchemaIntProperty('FontSize', fontSize ?? 16),
          'FontWeight': SchemaFontWeightProperty(
              'FontWeight', fontWeight ?? FontWeight.w500),
          'Column': SchemaStringProperty('Column', column ?? null),
          'MainAlignment': SchemaMainAlignmentProperty(
              'MainAlignment', MainAxisAlignment.start),
          'CrossAlignment': SchemaCrossAlignmentProperty(
              'CrossAlignment', CrossAxisAlignment.start),
        };

    textDebouncer =
        Debouncer(milliseconds: 500, prevValue: this.properties['Text'].value);
  }

  @override
  SchemaNode copy(
      {Offset position,
      Offset size,
      UniqueKey id,
      bool saveProperties = true}) {
    return parent.spawnSchemaNodeText(
      position: position ?? this.position,
      id: id ?? this.id,
      size: size ?? this.size,
      properties: saveProperties ? this._copyProperties() : null,
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
  Widget toWidget({ bool isPlayMode }) {
    return Shared.Text(
        properties: properties, theme: parent.userActions.themeStore.currentTheme, size: size);
  }

  void updateOnColumnDataChange(String newValue) {
    parent.userActions.changePropertyTo(SchemaStringProperty("Text", newValue), false);
  }

  @override
  Widget toEditProps(wrapInRootProps) {
    log(parent.userActions.remoteAttributeList().toString());
    return wrapInRootProps(
      Column(children: [
        ColumnDivider(
          name: 'Text Style',
        ),
        EditPropsText(
            id: id,
            properties: properties,
            propName: 'Text',
            userActions: parent.userActions,
            textDebouncer: textDebouncer),
        SizedBox(
          height: 10,
        ),
        EditPropsFontStyle(
          currentTheme: parent.userActions.themeStore.currentTheme,
          userActions: parent.userActions,
          properties: properties,
        ),
      ])
    );
  }
}
