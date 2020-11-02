import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsColor.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsCorners.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaIntProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaMyThemePropProperty.dart';
import 'package:flutter_app/features/schemaNodes/schemaAction.dart';
import 'package:flutter_app/shared_widgets/shape.dart' as Shared;
import 'package:flutter_app/ui/ColumnDivider.dart';

import 'SchemaNodeSpawner.dart';

class SchemaNodeShape extends SchemaNode {
  SchemaNodeShape({
    @required SchemaNodeSpawner parent,
    UniqueKey id,
    Offset position,
    Offset size,
    Map<String, SchemaNodeProperty> properties,
    Map<String, SchemaNodeProperty> actions,
  }) : super() {
    this.parent = parent;
    this.type = SchemaNodeType.shape;
    this.position = position ?? Offset(0, 0);
    this.size = size ?? Offset(375.0, 60.0);
    this.id = id ?? UniqueKey();
    this.actions = actions ?? {'Tap': GoToScreenAction('Tap', null)};
    this.properties = properties ??
        {
          'Color': SchemaMyThemePropProperty(
              'Color', parent.userActions.themeStore.currentTheme.primary),
          'BorderRadiusValue': SchemaIntProperty('BorderRadiusValue', 0),
        };
  }

  @override
  SchemaNode copy(
      {Offset position,
      Offset size,
      UniqueKey id,
      bool saveProperties = true}) {
    return parent.spawnSchemaNodeShape(
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
    return Shared.Shape(
        properties: properties, theme: parent.userActions.themeStore.currentTheme, size: size);
  }

  @override
  Widget toEditProps(wrapInRootProps) {
    return wrapInRootProps(
      Column(
        children: [
          ColumnDivider(
            name: 'Shape Style',
          ),
          EditPropsColor(
            currentTheme: parent.userActions.themeStore.currentTheme,
            properties: properties,
            propName: 'Color',
            userActions: parent.userActions,
          ),
          SizedBox(
            height: 12,
          ),
          EditPropsCorners(
            value: properties['BorderRadiusValue'].value,
            onChanged: (int value) {
              parent.userActions.changePropertyTo(
                  SchemaIntProperty('BorderRadiusValue', value));
            },
          )
        ],
      )
    );
  }
}
