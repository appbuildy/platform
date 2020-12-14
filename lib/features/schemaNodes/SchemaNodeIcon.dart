import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaBoolPropery.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaDoubleProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaIconProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaIntProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaMyThemePropProperty.dart';
import 'package:flutter_app/features/schemaNodes/schemaAction.dart';
import 'package:flutter_app/shared_widgets/icon.dart' as Shared;
import 'package:flutter_app/ui/ColumnDivider.dart';
import 'package:flutter_app/ui/SelectIconList.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'SchemaNodeSpawner.dart';
import 'common/EditPropsIconStyle.dart';
import 'common/EditPropsOpacity.dart';

class SchemaNodeIcon extends SchemaNode {
  SchemaNodeIcon({
    @required SchemaNodeSpawner parent,
    UniqueKey id,
    Offset position,
    Offset size,
    Map<String, SchemaNodeProperty> properties,
    GoToScreenAction tapAction,
    IconData icon,
    Map<String, SchemaNodeProperty> actions,
    int iconSize,
  }) : super() {
    this.parentSpawner = parent;
    this.type = SchemaNodeType.icon;
    this.position = position ?? Offset(0, 0);
    this.size = size ?? Offset(40.0, 40.0);
    this.id = id ?? UniqueKey();
    this.actions =
        actions ?? {'Tap': tapAction ?? GoToScreenAction('Tap', null)};
    this.properties = properties ??
        {
          'Icon':
              SchemaIconProperty('Icon', icon ?? FontAwesomeIcons.arrowRight),
          'IconColor': SchemaMyThemePropProperty('IconColor', parent.userActions.currentTheme.primary),
          'IconSize': SchemaIntProperty('IconSize', iconSize ?? 36),
          'BorderRadiusValue': SchemaIntProperty('BorderRadiusValue', 0),
          'BoxShadow': SchemaBoolProperty('BoxShadow', false),
          'BoxShadowColor': SchemaMyThemePropProperty(
              'BoxShadowColor', parent.userActions.currentTheme.general),
          'BoxShadowBlur': SchemaIntProperty('BoxShadowBlur', 5),
          'Opacity': SchemaDoubleProperty('Opacity', 1),
        };
  }

  @override
  SchemaNode copy(
      {Offset position,
      Offset size,
      UniqueKey id,
      bool saveProperties = true}) {
    return parentSpawner.spawnSchemaNodeIcon(
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
  Widget toWidget({bool isPlayMode}) {
    return Shared.Icon(
      properties: properties,
      theme: parentSpawner.userActions.themeStore.currentTheme,
      size: size,
    );
  }

  @override
  Widget toEditProps(wrapInRootProps,
      Function(SchemaNodeProperty, [bool, dynamic]) changePropertyTo) {
    return wrapInRootProps(Column(children: [
      ColumnDivider(
        name: 'Icon Style',
      ),
      EditPropsIconStyle(
        currentTheme: parentSpawner.userActions.themeStore.currentTheme,
        changePropertyTo: changePropertyTo,
        properties: properties,
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
        height: 12,
      ),
      SelectIconList(
          subListHeight: 350,
          selectedIcon: properties['Icon'].value,
          onChanged: (IconData icon) {
            changePropertyTo(SchemaIconProperty('Icon', icon));
          })
    ]));
  }
}
