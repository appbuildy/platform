import 'package:flutter/material.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_app/ui/HoverDecoration.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/utils/DarkenColor.dart';

import 'ColorPicker.dart';

class BuildColorSelect extends StatelessWidget {
  const BuildColorSelect({
    @required this.themeColor,
    @required this.onColorChange,
  });
  final Function onColorChange;
  final MyThemeProp themeColor;

  @override
  Widget build(BuildContext context) {
    final defaultDecoration = BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        gradient: MyGradients.buttonLightWhite,
        border: Border.all(width: 1, color: MyColors.borderGray));

    final hoverDecoration = BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        gradient: MyGradients.buttonLightBlue,
        border: Border.all(width: 1, color: MyColors.borderGray));

    void showColorPicker() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return BuildColorPicker(
            themeColor: themeColor,
            onColorChange: onColorChange,
          );
        },
      );
    }

    return Cursor(
        cursor: CursorEnum.pointer,
        child: GestureDetector(
          onTap: showColorPicker,
          child: HoverDecoration(
            hoverDecoration: hoverDecoration,
            defaultDecoration: defaultDecoration,
            child: Padding(
              padding: EdgeInsets.only(
                  top: 9, bottom: 8, left: 10, right: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: themeColor.color.darken(0.15)),
                        borderRadius: BorderRadius.circular(3),
                        color: themeColor.color),
                  ),
                  SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            themeColor.name,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Text(
                          '#${themeColor.color.value.toRadixString(16).toUpperCase()}',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Image.network(
                    'assets/icons/meta/expand-vertical.svg',
                    color: MyColors.iconGray,
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}