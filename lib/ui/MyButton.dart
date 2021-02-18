import 'package:flutter/material.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_app/ui/HoverDecoration.dart';
import 'package:flutter_app/ui/MyColors.dart';

class MyButtonUI extends StatelessWidget {
  final String text;
  final Widget icon;
  final bool disabled;
  final String type;

  MyButtonUI({
    @required this.text,
    this.icon,
    this.disabled = false,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    var defaultDecoration = BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        gradient: MyGradients.mainBlue,
        boxShadow: []);
    var hoverDecoration = BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        gradient: MyGradients.mainLightBlue,
        boxShadow: []);

    var textStyle = TextStyle(
        color: MyColors.white, fontSize: 16, fontWeight: FontWeight.w500);

    if (disabled) {
      defaultDecoration = BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          gradient: MyGradients.disabledLightGray,
          boxShadow: []);
      hoverDecoration = BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          gradient: MyGradients.disabledLightGray,
          boxShadow: []);
    }

    if (type == 'white') {
      defaultDecoration = BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: MyColors.mainBlue, width: 2),
        gradient: MyGradients.plainWhite,
      );
      hoverDecoration = BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: MyColors.mainBlue, width: 2),
        gradient: MyGradients.lightBlue,
      );
      textStyle = TextStyle(
          color: MyColors.textBlue, fontSize: 16, fontWeight: FontWeight.w500);
    }

    return Cursor(
      cursor: disabled ? CursorEnum.defaultCursor : CursorEnum.pointer,
      child: HoverDecoration(
        defaultDecoration: defaultDecoration,
        hoverDecoration: hoverDecoration,
        child: Padding(
          padding: const EdgeInsets.only(top: 9, bottom: 8),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  this.text,
                  style: textStyle,
                ),
              ),
              this.icon != null
                  ? Positioned(
                      left: 13,
                      top: 1,
                      child: Center(child: this.icon),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  final String text;
  final Widget icon;
  final String type;
  final bool disabled;
  final Function onTap;

  const MyButton(
      {Key key,
      @required this.text,
      this.icon,
      this.onTap,
      this.disabled = false,
      this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MyButtonUI(
          text: this.text,
          icon: this.icon,
          type: this.type,
          disabled: this.disabled),
    );
  }
}
