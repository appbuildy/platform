import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsColor.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsCorners.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsText.dart';
import 'package:flutter_app/features/schemaNodes/schemaAction.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/AppThemeStore.dart';
import 'package:flutter_app/utils/Debouncer.dart';
import 'package:flutter_app/utils/getThemeColor.dart';

class SchemaNodeButton extends SchemaNode {
  Debouncer<String> textDebouncer;

  SchemaNodeButton({
    Offset position,
    Offset size,
    @required AppThemeStore theme,
    Map<String, SchemaNodeProperty> properties,
    Map<String, SchemaNodeProperty> actions,
    UniqueKey id,
  }) : super() {
    this.type = SchemaNodeType.button;
    this.position = position ?? Offset(0, 0);
    this.size = size ?? Offset(150.0, 100.0);
    this.id = id ?? UniqueKey();
    this.theme = theme;
    this.actions = actions ?? {'Tap': GoToScreenAction('Tap', 'main')};
    this.properties = properties ??
        {
          'Text': SchemaStringProperty('Text', 'Button'),
          'TextColor': SchemaMyThemePropProperty(
              'TextColor', this.theme.currentTheme.general),
          'BorderColor': SchemaMyThemePropProperty(
              'BorderColor', this.theme.currentTheme.primary),
          'BackgroundColor': SchemaMyThemePropProperty(
              'BackgroundColor', this.theme.currentTheme.background),
          'BorderRadiusValue': SchemaIntProperty('BorderRadiusValue', 12),
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
    return SchemaNodeButton(
        position: position ?? this.position,
        id: id ?? this.id,
        size: size ?? this.size,
        theme: this.theme,
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
  Widget toWidget() {
    return Container(
      width: size.dx,
      height: size.dy,
      decoration: BoxDecoration(
          color: getThemeColor(theme, properties['BackgroundColor']),
          borderRadius:
              BorderRadius.circular(properties['BorderRadiusValue'].value),
          border: Border.all(
              width: 1,
              color: getThemeColor(theme, properties['BorderColor']))),
      child: Center(
          child: Text(
        properties['Text'].value,
        style: TextStyle(color: getThemeColor(theme, properties['TextColor'])),
      )),
    );
  }

  @override
  Widget toEditProps(userActions) {
    return Column(children: [
      EditPropsText(
          id: id,
          properties: properties,
          propName: 'Text',
          userActions: userActions,
          textDebouncer: textDebouncer),
      SizedBox(
        height: 10,
      ),
      EditPropsColor(
        theme: theme,
        properties: properties,
        userActions: userActions,
        propName: 'BackgroundColor',
      ),
      EditPropsCorners(
        value: properties['BorderRadiusValue'].value,
        onChanged: (int value) {
          userActions
              .changePropertyTo(SchemaIntProperty('BorderRadiusValue', value));
        },
      ),
    ]);
  }
}
