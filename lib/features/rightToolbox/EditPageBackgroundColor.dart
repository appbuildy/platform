import 'package:flutter/material.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_app/config/colors.dart';
import 'package:flutter_app/ui/MySelects/MyColorSelect.dart';

class EditBackgroundColor extends StatelessWidget {
  final MyTheme currentTheme;
  final Function onChange;
  final MyThemeProp selectedValue;
  final String title;

  EditBackgroundColor({
    Key key,
    @required this.currentTheme,
    this.title,
    @required this.onChange,
    @required this.selectedValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 60,
          child: Text(
            title ?? 'Color',
            style: MyTextStyle.regularCaption,
          ),
        ),
        Expanded(
          child: MyColorSelect(
            currentTheme: currentTheme,
            selectedValue: selectedValue,
            onChange: onChange,
          ),
        )
      ],
    );
  }
}
