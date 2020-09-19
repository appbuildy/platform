import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/features/rightToolbox/RemoteAttributeSelect.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/schemaAction.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/AppThemeStore.dart';
import 'package:flutter_app/ui/IconRectangleButton.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MySelects/MyClickSelect.dart';
import 'package:flutter_app/ui/MySelects/MySelects.dart';
import 'package:flutter_app/utils/Debouncer.dart';
import 'package:flutter_app/utils/getThemeColor.dart';

import 'common/EditPropsColor.dart';
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
          'TextColor': SchemaMyThemePropProperty(
              'TextColor', this.theme.currentTheme.general),
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
              color: getThemeColor(theme, properties['TextColor'])),
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
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              width: 59,
              child: Text(
                'Size',
                style: MyTextStyle.regularCaption,
              )),
          Expanded(
            child: MyClickSelect(
                selectedValue: properties['FontSize'].value,
                options: [
                  SelectOption('9', 9),
                  SelectOption('10', 10),
                  SelectOption('11', 11),
                  SelectOption('12', 12),
                  SelectOption('13', 13),
                  SelectOption('14', 14),
                  SelectOption('16', 16),
                  SelectOption('18', 18),
                  SelectOption('24', 24),
                  SelectOption('36', 36),
                  SelectOption('48', 48),
                  SelectOption('72', 72),
                  SelectOption('96', 96),
                ],
                onChange: (SelectOption option) {
                  userActions.changePropertyTo(
                      SchemaIntProperty('FontSize', option.value));
                }),
          )
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              width: 59,
              child: Text(
                'Weight',
                style: MyTextStyle.regularCaption,
              )),
          Expanded(
            child: MyClickSelect(
                selectedValue: properties['FontWeight'].value,
                options: [
                  SelectOption('Thin', FontWeight.w100),
                  SelectOption('Light', FontWeight.w300),
                  SelectOption('Regular', FontWeight.w400),
                  SelectOption('Medium', FontWeight.w500),
                  SelectOption('Semi-Bold', FontWeight.w600),
                  SelectOption('Bold', FontWeight.w700),
                  SelectOption('Black', FontWeight.w900),
                ],
                onChange: (SelectOption option) {
                  userActions.changePropertyTo(
                      SchemaFontWeightProperty('FontWeight', option.value));
                }),
          )
        ],
      ),
      SizedBox(
        height: 10,
      ),
      EditPropsColor(
        theme: theme,
        properties: properties,
        userActions: userActions,
        propName: 'TextColor',
      ),
      SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Alignment',
            style: MyTextStyle.regularCaption,
          ),
          Row(
            children: [
              MyIconRectangleButton(
                onTap: () {
                  userActions.changePropertyTo(
                      SchemaTextAlignProperty('TextAlign', TextAlign.start));
                },
                isActive: properties['TextAlign'].value == TextAlign.start,
                assetPath: 'assets/icons/text/horizontal-left.svg',
              ),
              SizedBox(
                width: 8,
              ),
              MyIconRectangleButton(
                onTap: () {
                  userActions.changePropertyTo(
                      SchemaTextAlignProperty('TextAlign', TextAlign.center));
                },
                isActive: properties['TextAlign'].value == TextAlign.center,
                assetPath: 'assets/icons/text/horizontal-center.svg',
              ),
              SizedBox(
                width: 8,
              ),
              MyIconRectangleButton(
                onTap: () {
                  userActions.changePropertyTo(
                      SchemaTextAlignProperty('TextAlign', TextAlign.end));
                },
                isActive: properties['TextAlign'].value == TextAlign.end,
                assetPath: 'assets/icons/text/horizontal-right.svg',
              )
            ],
          )
        ],
      ),
      SizedBox(
        height: 10,
      ),
      RemoteAttributesSelect(
          property: properties['Text'], userActions: userActions),
    ]);
  }
}
