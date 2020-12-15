import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaBoolPropery.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaIconProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaIntProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaMyThemePropProperty.dart';
import 'package:flutter_app/features/schemaNodes/schemaAction.dart';
import 'package:flutter_app/shared_widgets/shared_widgets.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/AppThemeStore.dart';
import 'package:flutter_app/ui/ColumnDivider.dart';
import 'package:flutter_app/ui/SelectIconList.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'common/EditPropsIconStyle.dart';

class SchemaNodeIcon extends SchemaNode {
  SchemaNodeIcon({
    Offset position,
    Offset size,
    @required AppThemeStore themeStore,
    Map<String, SchemaNodeProperty> properties,
    GoToScreenAction tapAction,
    IconData icon,
    Map<String, SchemaNodeProperty> actions,
    int iconSize,
    UniqueKey id,
  }) : super() {
    this.type = SchemaNodeType.icon;
    this.position = position ?? Offset(0, 0);
    this.size = size ?? Offset(40.0, 40.0);
    this.themeStore = themeStore;

    this.id = id ?? UniqueKey();
    this.actions =
        actions ?? {'Tap': tapAction ?? GoToScreenAction('Tap', null)};
    this.properties = properties ??
        {
          'Icon':
              SchemaIconProperty('Icon', icon ?? FontAwesomeIcons.arrowRight),
          'IconColor': SchemaMyThemePropProperty(
              'IconColor', this.themeStore.currentTheme.primary),
          'IconSize': SchemaIntProperty('IconSize', iconSize ?? 36),
          'BorderRadiusValue': SchemaIntProperty('BorderRadiusValue', 0),
          'BoxShadow': SchemaBoolProperty('BoxShadow', false),
          'BoxShadowColor': SchemaMyThemePropProperty(
              'BoxShadowColor', this.themeStore.currentTheme.general),
          'BoxShadowBlur': SchemaIntProperty('BoxShadowBlur', 5),
        };
  }

  @override
  SchemaNode copy(
      {Offset position,
      Offset size,
      UniqueKey id,
      bool saveProperties = true}) {
    return SchemaNodeIcon(
      position: position ?? this.position,
      id: id ?? this.id,
      size: size ?? this.size,
      themeStore: this.themeStore,
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
  Widget toWidget({bool isPlayMode, UserAction userActions}) {
    return SharedIcon(
      properties: properties,
      theme: themeStore.currentTheme,
      size: size,
    );
  }

  @override
  Widget toEditProps(userActions) {
    return Column(children: [
      ColumnDivider(
        name: 'Icon Style',
      ),
      EditPropsIconStyle(
        currentTheme: themeStore.currentTheme,
        userActions: userActions,
        properties: properties,
      ),
      SizedBox(
        height: 10,
      ),
      SelectIconList(
          subListHeight: 470,
          selectedIcon: properties['Icon'].value,
          onChanged: (IconData icon) {
            userActions.changePropertyTo(SchemaIconProperty('Icon', icon));
          })
    ]);
  }
}
