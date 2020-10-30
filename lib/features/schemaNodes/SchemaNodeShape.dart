import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsColor.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsCorners.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaIntProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaMyThemePropProperty.dart';
import 'package:flutter_app/features/schemaNodes/schemaAction.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/AppThemeStore.dart';
import 'package:flutter_app/ui/ColumnDivider.dart';
import 'package:flutter_app/utils/getThemeColor.dart';

class SchemaNodeShape extends SchemaNode {
  SchemaNodeShape({
    Offset position,
    Offset size,
    @required AppThemeStore themeStore,
    Map<String, SchemaNodeProperty> properties,
    Map<String, SchemaNodeProperty> actions,
    UniqueKey id,
  }) : super() {
    this.type = SchemaNodeType.shape;
    this.position = position ?? Offset(0, 0);
    this.size = size ?? Offset(375.0, 60.0);
    this.id = id ?? UniqueKey();
    this.themeStore = themeStore;
    this.actions = actions ?? {'Tap': GoToScreenAction('Tap', null)};
    this.properties = properties ??
        {
          'Color': SchemaMyThemePropProperty(
              'Color', this.themeStore.currentTheme.primary),
          'BorderRadiusValue': SchemaIntProperty('BorderRadiusValue', 0),
        };
  }

  @override
  SchemaNode copy(
      {Offset position,
      Offset size,
      UniqueKey id,
      bool saveProperties = true}) {
    return SchemaNodeShape(
        position: position ?? this.position,
        id: id ?? this.id,
        size: size ?? this.size,
        properties: saveProperties ? this._copyProperties() : null,
        themeStore: this.themeStore);
  }

  Map<String, SchemaNodeProperty> _copyProperties() {
    final newProps = Map<String, SchemaNodeProperty>();
    this.properties.forEach((key, value) {
      newProps[key] = value.copy();
    });

    return newProps;
  }

  @override
  Widget toWidget({bool isPlayMode, UserActions userActions}) {
    return Container(
      width: size.dx,
      height: size.dy,
      decoration: BoxDecoration(
          color: getThemeColor(
            themeStore.currentTheme,
            properties['Color'],
          ),
          borderRadius:
              BorderRadius.circular(properties['BorderRadiusValue'].value)),
    );
  }

  @override
  Widget toEditProps(userActions, wrapInRootProps) {
    return wrapInRootProps(
      Column(
        children: [
          ColumnDivider(
            name: 'Shape Style',
          ),
          EditPropsColor(
            currentTheme: themeStore.currentTheme,
            properties: properties,
            propName: 'Color',
            userActions: userActions,
          ),
          SizedBox(
            height: 12,
          ),
          EditPropsCorners(
            value: properties['BorderRadiusValue'].value,
            onChanged: (int value) {
              userActions.changePropertyTo(
                  SchemaIntProperty('BorderRadiusValue', value));
            },
          )
        ],
      )
    );
  }
}
