import 'package:flutter/material.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class BuildColorPicker extends StatelessWidget {
  const BuildColorPicker({
    @required this.themeColor,
    @required this.onColorChange,
  });
  final Function onColorChange;
  final MyThemeProp themeColor;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.all(0.0),
      contentPadding: const EdgeInsets.all(0.0),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: themeColor.color,
          onColorChanged: onColorChange,
          colorPickerWidth: 300.0,
          enableAlpha: true,
          displayThumbColor: true,
          showLabel: true,
          paletteType: PaletteType.hsv,
          pickerAreaBorderRadius: const BorderRadius.only(
            topLeft: const Radius.circular(2.0),
            topRight: const Radius.circular(2.0),
          ),
        ),
      ),
    );
  }
}