import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsBorder.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsColor.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsCorners.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsShadow.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaBoolPropery.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaDoubleProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaIntProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaMyThemePropProperty.dart';
import 'package:flutter_app/shared_widgets/shape.dart' as Shared;
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_app/ui/ColumnDivider.dart';

import 'SchemaNodeSpawner.dart';
import 'common/EditPropsOpacity.dart';
import 'my_do_nothing_action.dart';

class SchemaNodeShape extends SchemaNode {
  SchemaNodeShape({
    @required SchemaNodeSpawner parent,
    UniqueKey id,
    Offset position,
    Offset size,
    Map<String, SchemaNodeProperty> properties,
    Map<String, SchemaNodeProperty> actions,
  }) : super() {
    this.parentSpawner = parent;
    this.type = SchemaNodeType.shape;
    this.position = position ?? Offset(0, 0);
    this.size = size ?? Offset(375.0, 60.0);
    this.id = id ?? UniqueKey();
    this.actions = actions ?? {'Tap': MyDoNothingAction('Tap')};
    this.properties = properties ??
        {
          'Color': SchemaMyThemePropProperty(
              'Color', parent.userActions.themeStore.currentTheme.primary),
          'BorderRadiusValue': SchemaIntProperty('BorderRadiusValue', 0),
          'Opacity': SchemaDoubleProperty('Opacity', 1),
          'Border': SchemaBoolProperty('Border', false),
          'BorderColor': SchemaMyThemePropProperty('BorderColor',
              parent.userActions.themeStore.currentTheme.primary),
          'BorderWidth': SchemaIntProperty('BorderWidth', 1),
          'BoxShadow': SchemaBoolProperty('BoxShadow', false),
          'BoxShadowColor': SchemaMyThemePropProperty('BoxShadowColor',
              parent.userActions.themeStore.currentTheme.general),
          'BoxShadowBlur': SchemaIntProperty('BoxShadowBlur', 5),
          'BoxShadowOpacity': SchemaDoubleProperty('BoxShadowOpacity', 0.5),
        };
  }

  @override
  SchemaNode copy(
      {Offset position,
      Offset size,
      UniqueKey id,
      bool saveProperties = true}) {
    return parentSpawner.spawnSchemaNodeShape(
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
  Widget toWidget({MyTheme theme, bool isPlayMode}) {
    return Shared.Shape(
      properties: properties,
      theme: theme ?? parentSpawner.userActions.themeStore.currentTheme,
      size: size,
    );
  }

  @override
  Widget toEditProps(wrapInRootProps,
      Function(SchemaNodeProperty, [bool, dynamic]) changePropertyTo) {
    return wrapInRootProps(Column(
      children: [
        ColumnDivider(
          name: 'Shape Style',
        ),
        EditPropsColor(
          currentTheme: parentSpawner.userActions.themeStore.currentTheme,
          properties: properties,
          propName: 'Color',
          changePropertyTo: changePropertyTo,
        ),
        SizedBox(
          height: 12,
        ),
        EditPropsCorners(
          value: properties['BorderRadiusValue'].value,
          onChanged: (int value) {
            changePropertyTo(SchemaIntProperty('BorderRadiusValue', value));
          },
        ),
        SizedBox(
          height: 12,
        ),
        EditPropsOpacity(
          value: properties['Opacity'].value,
          onChanged: (double value) {
            changePropertyTo(SchemaDoubleProperty('Opacity', value));
          },
        ),
        SizedBox(
          height: 20,
        ),
        EditPropsBorder(
          key: id,
          properties: properties,
          changePropertyTo: changePropertyTo,
          currentTheme: parentSpawner.userActions.currentTheme,
        ),
        SizedBox(
          height: 15,
        ),
        EditPropsShadow(
          properties: properties,
          changePropertyTo: changePropertyTo,
          currentTheme: parentSpawner.userActions.currentTheme,
        )
      ],
    ));
  }
}
