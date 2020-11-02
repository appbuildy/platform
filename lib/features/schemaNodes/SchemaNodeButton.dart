import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsBorder.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsColor.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsCorners.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsFontStyle.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsShadow.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsText.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaBoolPropery.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaCrossAlignmentProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaDoubleProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaFontWeightProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaIntProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaMainAlignmentProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaMyThemePropProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaStringProperty.dart';
import 'package:flutter_app/features/schemaNodes/schemaAction.dart';
import 'package:flutter_app/shared_widgets/button.dart' as Shared;
import 'package:flutter_app/ui/ColumnDivider.dart';
import 'package:flutter_app/utils/Debouncer.dart';

import 'SchemaNodeSpawner.dart';

class SchemaNodeButton extends SchemaNode {
  Debouncer<String> textDebouncer;

  SchemaNodeButton({
    @required SchemaNodeSpawner parent,
    UniqueKey id,
    Offset position,
    Offset size,
    Map<String, SchemaNodeProperty> properties,
    Map<String, SchemaNodeProperty> actions,
    String text,
  }) : super() {
    this.parent = parent;
    this.type = SchemaNodeType.button;
    this.position = position ?? Offset(0, 0);
    this.size = size ?? Offset(343.0, 50.0);
    this.id = id ?? UniqueKey();
    this.actions = actions ?? {'Tap': GoToScreenAction('Tap', null)};
    this.properties = properties ??
        {
          'Text': SchemaStringProperty('Text', text ?? 'Button'),
          'FontColor': SchemaMyThemePropProperty(
              'FontColor', parent.userActions.themeStore.currentTheme.generalInverted),
          'FontSize': SchemaIntProperty('FontSize', 16),
          'FontWeight': SchemaFontWeightProperty('FontWeight', FontWeight.w500),
          'MainAlignment': SchemaMainAlignmentProperty(
              'MainAlignment', MainAxisAlignment.center),
          'CrossAlignment': SchemaCrossAlignmentProperty(
              'CrossAlignment', CrossAxisAlignment.center),
          'Border': SchemaBoolProperty('Border', false),
          'BorderColor': SchemaMyThemePropProperty(
              'BorderColor', parent.userActions.themeStore.currentTheme.primary),
          'BorderWidth': SchemaIntProperty('BorderWidth', 1),
          'BackgroundColor': SchemaMyThemePropProperty(
              'BackgroundColor', parent.userActions.themeStore.currentTheme.primary),
          'BorderRadiusValue': SchemaIntProperty('BorderRadiusValue', 9),
          'BoxShadow': SchemaBoolProperty('BoxShadow', false),
          'BoxShadowColor': SchemaMyThemePropProperty(
              'BoxShadowColor', parent.userActions.themeStore.currentTheme.general),
          'BoxShadowBlur': SchemaIntProperty('BoxShadowBlur', 5),
          'BoxShadowOpacity': SchemaDoubleProperty('BoxShadowOpacity', 0.5),
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
    return parent.spawnSchemaNodeButton(
        position: position ?? this.position,
        id: id ?? this.id,
        size: size ?? this.size,
        properties: saveProperties ? this._copyProperties() : null);
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
    return Shared.Button(
        properties: properties, theme: parent.userActions.themeStore.currentTheme, size: size);
  }

  @override
  Widget toEditProps(wrapInRootProps) {
    return wrapInRootProps(
        Column(children: [
        ColumnDivider(name: 'Text Style'),
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
          currentTheme: parent.userActions.currentTheme,
          userActions: parent.userActions,
          properties: properties,
        ),
        ColumnDivider(name: 'Shape Style'),
        EditPropsColor(
          currentTheme: parent.userActions.currentTheme,
          properties: properties,
          userActions: parent.userActions,
          propName: 'BackgroundColor',
        ),
        SizedBox(
          height: 12,
        ),
        EditPropsCorners(
          value: properties['BorderRadiusValue'].value,
          onChanged: (int value) {
            parent.userActions
                .changePropertyTo(SchemaIntProperty('BorderRadiusValue', value));
          },
        ),
        SizedBox(
          height: 20,
        ),
        EditPropsBorder(
          key: id,
          properties: properties,
          userActions: parent.userActions,
          currentTheme: parent.userActions.currentTheme,
        ),
        SizedBox(
          height: 15,
        ),
        EditPropsShadow(
            properties: properties,
            userActions: parent.userActions,
            currentTheme: parent.userActions.currentTheme)
      ])
    );
  }
}
