import 'package:flutter/material.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_app/ui/HoverDecoration.dart';
import 'package:flutter_app/ui/IconHover.dart';
import 'package:flutter_app/ui/MyColors.dart';

class MyIconRectangleButton extends StatelessWidget {
  final bool isActive;
  final String assetPath;
  final Function onTap;

  const MyIconRectangleButton(
      {Key key,
      this.isActive = false,
      @required this.assetPath,
      @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final activeDecoration = BoxDecoration(
        gradient: MyGradients.lightBlue,
        borderRadius: BorderRadius.circular(6));

    final defaultDecoration = isActive
        ? activeDecoration
        : BoxDecoration(
            gradient: MyGradients.plainWhite,
            borderRadius: BorderRadius.circular(6));
    final hoverDecoration = isActive
        ? activeDecoration
        : BoxDecoration(
            gradient: MyGradients.lightGray,
            borderRadius: BorderRadius.circular(6));

    return GestureDetector(
      onTap: onTap,
      child: Cursor(
        cursor: isActive ? CursorEnum.defaultCursor : CursorEnum.pointer,
        child: SizedBox(
          width: 32,
          height: 32,
          child: HoverDecoration(
            hoverDecoration: hoverDecoration,
            defaultDecoration: defaultDecoration,
            child: IconHover(
              isActive: isActive,
              assetPath: assetPath,
            ),
          ),
        ),
      ),
    );
  }
}
