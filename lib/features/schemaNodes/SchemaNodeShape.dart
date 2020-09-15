import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/schemaAction.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/AppThemeStore.dart';
import 'package:flutter_app/ui/MySelects/MyClickSelect.dart';
import 'package:flutter_app/ui/MySelects/MySelects.dart';

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
      color: theme.currentTheme
          .getThemePropByName(properties['Color'].value.name)
          .color,
    );
  }

  @override
  Widget toEditProps(userActions) {
//    final theme = userActions.theme.currentTheme;
    log('theme name bro ${theme.currentTheme.name}');

    return Column(
      children: [
        Row(children: [
          GestureDetector(
            onTap: () {
              userActions
                  .changePropertyTo(SchemaColorProperty('Color', Colors.black));
            },
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(color: Colors.black),
            ),
          ),
        ]),
        MyClickSelect(
            selectedValue: properties['Color'].value,
            onChange: (option) {
              userActions.changePropertyTo(
                  SchemaMyThemePropProperty('Color', option.value));
            },
            options: [
              SelectOption(
                  'Primary',
                  theme.currentTheme.primary,
                  Container(
                      width: 15,
                      height: 15,
                      color: theme.currentTheme.primary.color)),
              SelectOption(
                  'Secondary',
                  theme.currentTheme.secondary,
                  Container(
                      width: 15,
                      height: 15,
                      color: theme.currentTheme.secondary.color)),
              SelectOption(
                  'Body',
                  theme.currentTheme.body,
                  Container(
                      width: 15,
                      height: 15,
                      color: theme.currentTheme.body.color)),
              SelectOption(
                  'Body secondary',
                  theme.currentTheme.bodySecondary,
                  Container(
                      width: 15,
                      height: 15,
                      color: theme.currentTheme.bodySecondary.color)),
              SelectOption(
                  'Background',
                  theme.currentTheme.background,
                  Container(
                      width: 15,
                      height: 15,
                      color: theme.currentTheme.background.color))
            ])
      ],
    );
  }
}
