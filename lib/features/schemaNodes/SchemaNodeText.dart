import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/features/rightToolbox/RemoteAttributeSelect.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsFontStyle.dart';
import 'package:flutter_app/features/schemaNodes/schemaAction.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/AppThemeStore.dart';
import 'package:flutter_app/utils/Debouncer.dart';
import 'package:flutter_app/utils/getThemeColor.dart';

import 'common/EditPropsText.dart';

class SchemaNodeText extends SchemaNode {
  Debouncer<String> textDebouncer;

  SchemaNodeText(
      {Offset position,
      Offset size,
      @required AppThemeStore theme,
      Map<String, SchemaNodeProperty> properties,
      UniqueKey id})
      : super() {
    this.type = SchemaNodeType.text;
    this.position = position ?? Offset(0, 0);
    this.size = size ?? Offset(150.0, 100.0);
    this.id = id ?? UniqueKey();
    this.theme = theme;

    this.actions = actions ?? {'Tap': GoToScreenAction('Tap', null)};
    this.properties = properties ??
        {
          'Text': SchemaStringProperty('Text', 'Text'),
          'FontColor': SchemaMyThemePropProperty(
              'FontColor', this.theme.currentTheme.general),
          'FontSize': SchemaIntProperty('FontSize', 16),
          'FontWeight': SchemaFontWeightProperty('FontWeight', FontWeight.w500),
          'TextAlign': SchemaTextAlignProperty('TextAlign', TextAlign.start),
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
    return SchemaNodeText(
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
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Text(
          properties['Text'].value,
          textAlign: properties['TextAlign'].value,
          style: TextStyle(
              fontSize: properties['FontSize'].value,
              fontWeight: properties['FontWeight'].value,
              color: getThemeColor(theme, properties['FontColor'])),
        ),
      ),
    );
  }

  @override
  Widget toEditProps(userActions) {
    log(userActions.remoteAttributeList().toString());
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
      EditPropsFontStyle(
        theme: theme,
        userActions: userActions,
        properties: properties,
      ),
      SizedBox(
        height: 10,
      ),
      RemoteAttributesSelect(
          property: properties['Text'], userActions: userActions),
    ]);
  }
}
