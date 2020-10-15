import 'package:flutter/material.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_app/ui/MySelects/MyClickSelect.dart';
import 'package:flutter_app/ui/MySelects/SelectOption.dart';
import 'package:flutter_app/utils/DarkenColor.dart';
import 'package:flutter_app/utils/StringExtentions/CapitalizeString.dart';
import 'package:flutter_app/utils/StringExtentions/FromSnakeCaseme;
  final dynamic selectedValue;
  final Function onChange;

  const MyColorSelect(
      {Key key,
      @required this.currentTheme,
      @required this.onChange,
      @required this.selectedValue})
      : super(key: key);

  Widget buildColorPreview(Color color) {
    return Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: color.darken(0.15)),
            borderRadius: BorderRadius.circular(3),
            color: color));
  }

  @override
  Widget build(BuildContext context) {
    return MyClickSelect(
      selectedValue: selectedValue,
      onChange: onChange,
      options: currentTheme.getAllColors().map((MyThemeProp color) {
        return SelectOption(
          color.name.toNormalCapitalizedString().capitalize(),
          color,
          buildColorPreview(color.color),
        );
      }).toList(),
    );
  }
}
