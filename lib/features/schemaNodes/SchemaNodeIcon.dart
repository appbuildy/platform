import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/schemaAction.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/AppThemeStore.dart';
import 'package:flutter_app/ui/ColumnDivider.dart';
import 'package:flutter_app/ui/SelectIconList.dart';
import 'package:flutter_app/utils/getThemeColor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'common/EditPropsIconStyle.dart';

class SchemaNodeIcon extends SchemaNode {
  SchemaNodeIcon(
      {Offset position,
      Offset size,
      @required AppThemeStore theme,
      Map<String, SchemaNodeProperty> properties,
      UniqueKey id})
      : super() {
    this.type = SchemaNodeType.icon;
    this.position = position ?? Offset(0, 0);
    this.size = size ?? Offset(40.0, 40.0);
    this.theme = theme;

    this.id = id ?? UniqueKey();
    this.actions = actions ?? {'Tap': GoToScreenAction('Tap', null)};
    this.properties = properties ??
        {
          'Icon': SchemaIconProperty('Icon', FontAwesomeIcons.arrowRight),
          'IconColor': SchemaMyThemePropProperty(
              'IconColor', this.theme.currentTheme.primary),
          'IconSize': SchemaIntProperty('IconSize', 36),
          'BorderRadiusValue': SchemaIntProperty('BorderRadiusValue', 0),
          'BoxShadow': SchemaBoolProperty('BoxShadow', false),
          'BoxShadowColor': SchemaMyThemePropProperty(
              'BoxShadowColor', this.theme.currentTheme.general),
          'BoxShadowBlur': SchemaIntProperty('BoxShadowBlur', 5),
        };
    ;
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
      theme: this.theme,
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
  Widget toWidget() {
    return Container(
      width: size.dx,
      height: size.dy,
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(properties['BorderRadiusValue'].value)),
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(properties['BorderRadiusValue'].value),
        child: FaIcon(
          properties['Icon'].value,
          size: properties['IconSize'].value,
          color: getThemeColor(theme, properties['IconColor']),
        ),
      ),
    );
  }

  @override
  Widget toEditProps(userActions) {
    return Column(children: [
      ColumnDivider(
        name: 'Icon Style',
      ),
      EditPropsIconStyle(
        theme: theme,
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
