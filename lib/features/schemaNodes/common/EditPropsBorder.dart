import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsColor.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaBoolPropery.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaIntProperty.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MySelects/MySelects.dart';
import 'package:flutter_app/ui/MySwitch.dart';

class EditPropsBorder extends StatelessWidget {
  final Map<String, SchemaNodeProperty> properties;
  //final UserActions userActions;
  final Function(SchemaNodeProperty, [bool, dynamic]) changePropertyTo;
  final MyTheme currentTheme;

  const EditPropsBorder(
      {Key key,
      @required this.properties,
      @required this.changePropertyTo,
      @required this.currentTheme})
      : super(key: key);

  List<Widget> buildBorderStyle() {
    if (properties['Border'].value == false) {
      return [Container()];
    } else {
      return [
        SizedBox(
          height: 10,
        ),
        EditPropsColor(
          currentTheme: currentTheme,
          changePropertyTo: changePropertyTo,
          propName: 'BorderColor',
          properties: properties,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            SizedBox(
                width: 59,
                child: Text(
                  'Width',
                  style: MyTextStyle.regularCaption,
                )),
            Expanded(
              child: MyClickSelect(
                  selectedValue: properties['BorderWidth'].value,
                  options: [
                    SelectOption('1', 1),
                    SelectOption('2', 2),
                    SelectOption('3', 3),
                    SelectOption('4', 4),
                    SelectOption('5', 5),
                    SelectOption('6', 6),
                    SelectOption('7', 7),
                    SelectOption('8', 8),
                    SelectOption('9', 9),
                    SelectOption('10', 10),
                  ],
                  onChange: (SelectOption option) {
                    changePropertyTo(
                        SchemaIntProperty('BorderWidth', option.value));
                  }),
            ),
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
              value: properties['Border'].value,
              onTap: () {
                changePropertyTo(
                    SchemaBoolProperty('Border', !properties['Border'].value));
              },
            ),
            SizedBox(
              width: 11,
            ),
            Text(
              'Border',
              style: MyTextStyle.regularTitle,
            )
          ],
        ),
        ...buildBorderStyle()
      ],
    );
  }
}
