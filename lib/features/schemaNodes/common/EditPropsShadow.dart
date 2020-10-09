import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsColor.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/AppThemeStore.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MySlider.dart';
import 'package:flutter_app/ui/MySwitch.dart';

class EditPropsShadow extends StatelessWidget {
  final Map<String, SchemaNodeProperty> properties;
  final UserActions userActions;
  final AppThemeStore theme;

  const EditPropsShadow(
      {Key key,
      @required this.properties,
      @required this.userActions,
      @required this.theme})
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
            theme: theme,
            userActions: userActions,
            propName: 'BoxShadowColor',
            properties: properties),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            SizedBox(
                width: 59,
                child: Text(
                  'Opacity',
                  style: MyTextStyle.regularCaption,
                )),
            Expanded(
              child: MySlider(
                max: 1,
                onChanged: (value) {
                  userActions.changePropertyTo(
                      SchemaIntProperty('BoxShadowOpacity', value));
                },
                value: properties['BoxShadowOpacity'].value,
              ),
            ),
            SizedBox(
              width: 18,
              child: Text(
                properties['BoxShadowOpacity'].value.toString(),
                textAlign: TextAlign.right,
                style: MyTextStyle.regularCaption,
              ),
            ),
            SizedBox(width: 2),
          ],
        ),
        Row(
          children: [
            SizedBox(
                width: 59,
                child: Text(
                  'Blur',
                  style: MyTextStyle.regularCaption,
                )),
            Expanded(
              child: MySlider(
                max: 0.5,
                onChanged: (value) {
                  userActions.changePropertyTo(SchemaIntProperty(
                      'BoxShadowBlur', (value * 100).toInt()));
                },
                value: properties['BoxShadowBlur'].value / 100,
              ),
            ),
            SizedBox(
              width: 18,
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
                userActions.changePropertyTo(SchemaBoolProperty(
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
