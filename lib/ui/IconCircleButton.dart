import 'package:flutter/material.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_app/ui/HoverDecoration.dart';
import 'package:flutter_app/ui/IconHover.dart';
import 'package:flutter_app/config/colors.dart';

class IconCircleButton extends StatelessWidget {
  final Widget icon;
  final String assetPath;
  final Function onTap;
  final bool isDisabled;

  const IconCircleButton(
      {Key key, this.icon, this.onTap, this.isDisabled = false, this.assetPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultDecoration =
        BoxDecoration(gradient: MyGradients.plainWhite, shape: BoxShape.circle);
    final hoverDecoration =
        BoxDecoration(gradient: MyGradients.lightBlue, shape: BoxShape.circle);

    if (isDisabled) {
      return Container(
        width: 38,
        height: 38,
        decoration: defaultDecoration,
        child: icon,
      );
    }

    return GestureDetector(
      onTap: onTap ?? () {},
      child: Cursor(
        cursor: CursorEnum.pointer,
        child: HoverDecoration(
          hoverDecoration: hoverDecoration,
          defaultDecoration: defaultDecoration,
          child: assetPath != null
              ? IconHover(assetPath: assetPath)
              : Container(
                  width: 38,
                  height: 38,
                  child: icon,
                ),
        ),
      ),
    );
  }
}
