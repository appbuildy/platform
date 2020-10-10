import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaMyThemePropProperty.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/AppThemeStore.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MySelects/MyColorSelect.dart';

class EditPropsColor extends StatelessWidget {
  final AppThemeStore theme;
  final UserActions userActions;
  final String propName;
  final Map<String, SchemaNodeProperty> properties;
  final String title;

  const EditPropsColor(
      {Key key,
      @required this.theme,
      this.title,
      @required this.userActions,
      @required this.propName,
      @required this.properties})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title ?? 'Color',
          style: MyTextStyle.regularCaption,
        ),
        SizedBox(
          width: 24,
        ),
        Expanded(
          child: MyColorSelect(
            theme: theme,
            selectedValue: properties[propName].value,
            onChange: (option) {
              userActions.changePropertyTo(
                  SchemaMyThemePropProperty(propName, option.value));
            },
          ),
        )
      ],
    );
  }
}
