import 'package:flutter/material.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/AppThemeStore.dart';
import 'package:flutter_app/ui/MySelects/MyClickSelect.dart';
import 'package:flutter_app/ui/MySelects/SelectOption.dart';
import 'package:flutter_app/utils/DarkenColor.dart';

class MyColorSelect extends StatelessWidget {
  final AppThemeStore theme;
  final dynamic selectedValue;
  final Function onChange;

  const MyColorSelect(
      {Key key,
      @required this.theme,
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
        options: [
          SelectOption(
            'Primary',
            theme.currentTheme.primary,
            buildColorPreview(theme.currentTheme.primary.color),
          ),
          SelectOption(
            'Secondary',
            theme.currentTheme.secondary,
            buildColorPreview(theme.currentTheme.secondary.color),
          ),
          SelectOption(
            'General',
            theme.currentTheme.general,
            buildColorPreview(theme.currentTheme.general.color),
          ),
          SelectOption(
            'General Second',
            theme.currentTheme.generalSecondary,
            buildColorPreview(theme.currentTheme.generalSecondary.color),
          ),
          SelectOption(
            'General Inverted',
            theme.currentTheme.generalInverted,
            buildColorPreview(theme.currentTheme.generalInverted.color),
          ),
          SelectOption(
            'Separators',
            theme.currentTheme.separators,
            buildColorPreview(theme.currentTheme.separators.color),
          ),
          SelectOption(
            'Background',
            theme.currentTheme.background,
            buildColorPreview(theme.currentTheme.background.color),
          )
        ]);
  }
}
