import 'package:flutter/material.dart';
import 'package:flutter_app/config/text_styles.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsColor.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaBoolPropery.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaDoubleProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaIntProperty.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_app/ui/MySlider.dart';
import 'package:flutter_app/ui/MySwitch.dart';

class EditPropsShadow extends StatelessWidget {
  final Map<String, SchemaNodeProperty> properties;
  //final UserActions userActions;
  final Function(SchemaNodeProperty, [bool, dynamic]) changePropertyTo;
  final MyTheme currentTheme;

  const EditPropsShadow(
      {Key key,
      @required this.properties,
      @required this.changePropertyTo,
      @required this.currentTheme})
      : super(key: key);

  List<Widget> buildBorderStyle() {
    if (properties['BoxShadow'].value == false) {
      return [Container()];
    } else {
      return [
        SizedBox(
          height: 10,
        ),
        EditPropsColor(
            currentTheme: currentTheme,
            changePropertyTo: changePropertyTo,
            propName: 'BoxShadowColor',
            properties: properties),
        SizedBox(
          height: 13,
        ),
        Row(
          children: [
            SizedBox(
                width: 50,
                child: Text(
                  'Opacity',
                  style: MyTextStyle.regularCaption,
                )),
            Expanded(
              child: MySlider(
                max: 1,
                onChanged: (value) {
                  changePropertyTo(SchemaDoubleProperty(
                      'BoxShadowOpacity', num.parse(value.toStringAsFixed(2))));
                },
                value: properties['BoxShadowOpacity'].value,
              ),
            ),
            SizedBox(
              width: 30,
              child: Text(
                properties['BoxShadowOpacity'].value.toString(),
                textAlign: TextAlign.right,
                style: MyTextStyle.regularCaption,
              ),
            ),
            SizedBox(width: 2),
          ],
        ),
        SizedBox(
          height: 13,
        ),
        Row(
          children: [
            SizedBox(
                width: 50,
                child: Text(
                  'Blur',
                  style: MyTextStyle.regularCaption,
                )),
            Expanded(
              child: MySlider(
                max: 0.5,
                onChanged: (value) {
                  changePropertyTo(SchemaIntProperty(
                      'BoxShadowBlur', (value * 100).toInt()));
                },
                value: properties['BoxShadowBlur'].value / 100,
              ),
            ),
            SizedBox(
              width: 30,
              child: Text(
                properties['BoxShadowBlur'].value.toString(),
                textAlign: TextAlign.right,
                style: MyTextStyle.regularCaption,
              ),
            ),
            SizedBox(width: 2),
          ],
        )
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            MySwitch(
              value: properties['BoxShadow'].value,
              onTap: () {
                changePropertyTo(SchemaBoolProperty(
                    'BoxShadow', !properties['BoxShadow'].value));
              },
            ),
            SizedBox(
              width: 11,
            ),
            Text(
              'Shadow',
              style: MyTextStyle.regularTitle,
            )
          ],
        ),
        ...buildBorderStyle()
      ],
    );
  }
}
