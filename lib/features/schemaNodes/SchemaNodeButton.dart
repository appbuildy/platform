import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
import 'package:flutter_app/store/userActions/AppThemeStore/AppThemeStore.dart';
import 'package:flutter_app/ui/ColumnDivider.dart';
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
    this.size = size ?? Offset(343.0, 50.0);
    this.id = id ?? UniqueKey();
    this.theme = theme;
    this.actions = actions ?? {'Tap': GoToScreenAction('Tap', null)};
    this.properties = properties ??
        {
          'Text': SchemaStringProperty('Text', 'Button'),
          'FontColor': SchemaMyThemePropProperty(
              'FontColor', this.theme.currentTheme.generalInverted),
          'FontSize': SchemaIntProperty('FontSize', 16),
          'FontWeight': SchemaFontWeightProperty('FontWeight', FontWeight.w500),
          'MainAlignment': SchemaMainAlignmentProperty(
              'MainAlignment', MainAxisAlignment.center),
          'CrossAlignment': SchemaCrossAlignmentProperty(
              'CrossAlignment', CrossAxisAlignment.center),
          'Border': SchemaBoolProperty('Border', false),
          'BorderColor': SchemaMyThemePropProperty(
              'BorderColor', this.theme.currentTheme.primary),
          'BorderWidth': SchemaIntProperty('BorderWidth', 1),
          'BackgroundColor': SchemaMyThemePropProperty(
              'BackgroundColor', this.theme.currentTheme.primary),
          'BorderRadiusValue': SchemaIntProperty('BorderRadiusValue', 9),
          'BoxShadow': SchemaBoolProperty('BoxShadow', false),
          'BoxShadowColor': SchemaMyThemePropProperty(
              'BoxShadowColor', this.theme.currentTheme.general),
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
  Widget toWidget({bool isPlayMode}) {
    return Container(
      width: size.dx,
      height: size.dy,
      decoration: BoxDecoration(
          color: getThemeColor(theme, properties['BackgroundColor']),
          boxShadow: properties['BoxShadow'].value
              ? [
                  BoxShadow(
                      color: getThemeColor(theme, properties['BoxShadowColor'])
                          .withOpacity(properties['BoxShadowOpacity'].value),
                      blurRadius: properties['BoxShadowBlur'].value,
                      offset: Offset(0.0, 2.0),
                      spreadRadius: 0)
                ]
              : [],
          borderRadius:
              BorderRadius.circular(properties['BorderRadiusValue'].value),
          border: properties['Border'].value
              ? Border.all(
                  width: properties['BorderWidth'].value,
                  color: getThemeColor(theme, properties['BorderColor']))
              : null),
      child: Column(
        mainAxisAlignment: properties['MainAlignment'].value,
        crossAxisAlignment: properties['CrossAlignment'].value,
        children: [
          Text(
            properties['Text'].value,
            style: TextStyle(
                fontWeight: properties['FontWeight'].value,
                fontSize: properties['FontSize'].value,
                color: getThemeColor(theme, properties['FontColor'])),
          ),
        ],
      ),
    );
  }

  @override
  Widget toEditProps(userActions) {
    return Column(children: [
      ColumnDivider(name: 'Text Style'),
      EditPropsText(
          id: id,
          properties: properties,
          propName: 'Text',
          userActions: userActions,
          textDebouncer: textDebouncer),
      SizedBox(
        height: 10,
      ),
      EditPropsFontStyle(
        theme: theme,
        userActions: userActions,
        properties: properties,
      ),
      ColumnDivider(name: 'Shape Style'),
      EditPropsColor(
        theme: theme,
        properties: properties,
        userActions: userActions,
        propName: 'BackgroundColor',
      ),
      SizedBox(
        height: 12,
      ),
      EditPropsCorners(
        value: properties['BorderRadiusValue'].value,
        onChanged: (int value) {
          userActions
              .changePropertyTo(SchemaIntProperty('BorderRadiusValue', value));
        },
      ),
      SizedBox(
        height: 20,
      ),
      EditPropsBorder(
        key: id,
        properties: properties,
        userActions: userActions,
        theme: theme,
      ),
      SizedBox(
        height: 15,
      ),
      EditPropsShadow(
          properties: properties, userActions: userActions, theme: theme)
    ]);
  }
}
