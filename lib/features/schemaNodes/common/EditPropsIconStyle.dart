import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsColor.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaIntProperty.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/AppThemeStore.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MySelects/MySelects.dart';

class EditPropsIconStyle extends StatelessWidget {
  final Map<String, SchemaNodeProperty> properties;
  final UserActions userActions;
  final AppThemeStore theme;

  const EditPropsIconStyle(
      {Key key,
      @required this.properties,
      @required this.userActions,
      @required this.theme})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        EditPropsColor(
          theme: theme,
          properties: properties,
          userActions: userActions,
          propName: 'IconColor',
        ),
        SizedBox(
          height: 10,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
              width: 59,
              child: Text(
                'Size',
                style: MyTextStyle.regularCaption,
              )),
          Expanded(
            child: MyClickSelect(
                selectedValue: properties['IconSize'].value,
                options: [
                  SelectOption('12', 12),
                  SelectOption('14', 14),
                  SelectOption('16', 16),
                  SelectOption('18', 18),
                  SelectOption('24', 24),
                  SelectOption('36', 36),
                  SelectOption('48', 48),
                  SelectOption('56', 56),
                  SelectOption('72', 72),
                  SelectOption('96', 96),
                ],
                onChange: (SelectOption option) {
                  userActions.changePropertyTo(
                      SchemaIntProperty('IconSize', option.value));
                }),
          )
        ]),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
