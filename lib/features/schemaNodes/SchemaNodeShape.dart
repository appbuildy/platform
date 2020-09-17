import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/schemaAction.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/AppThemeStore.dart';
import 'package:flutter_app/ui/MySelects/MyColorSelect.dart';
import 'package:flutter_app/utils/getThemeColor.dart';

class SchemaNodeShape extends SchemaNode {
  SchemaNodeShape({
    Offset position,
    Offset size,
    @required AppThemeStore theme,
    Map<String, SchemaNodeProperty> properties,
    UniqueKey id,
  }) : super() {
    this.type = SchemaNodeType.shape;
    this.position = position ?? Offset(0, 0);
    this.size = size ?? Offset(150.0, 100.0);
    this.id = id ?? UniqueKey();
    this.theme = theme;
    this.actions = actions ?? {'Tap': GoToScreenAction('Tap', 'main')};
    this.properties = properties ??
        {
          'Color': SchemaMyThemePropProperty(
              'Color', this.theme.currentTheme.primary)
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
        theme: this.theme);
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
      color: getThemeColor(theme, properties['Color']),
    );
  }

  @override
  Widget toEditProps(userActions) {
//    final theme = userActions.theme.currentTheme;
    log('theme name bro ${theme.currentTheme.name}');

    return Column(
      children: [
        Row(children: []),
        MyColorSelect(
          theme: theme,
          selectedValue: properties['Color'].value,
          onChange: (option) {
            userActions.changePropertyTo(
                SchemaMyThemePropProperty('Color', option.value));
          },
        )
      ],
    );
  }
}
