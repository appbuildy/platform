import 'package:flutter/material.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_app/ui/HoverDecoration.dart';
import 'package:flutter_app/ui/MyColors.dart';

class MyButtonUI extends StatelessWidget {
  final String text;
  final Widget icon;
  final bool disabled;

  MyButtonUI({
    @required this.text,
    this.icon,
    this.disabled = false,
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
                  style: TextStyle(
                      color: MyColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
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
  final bool disabled;
  final Function onTap;

  const MyButton(
      {Key key,
      @required this.text,
      this.icon,
      this.onTap,
      this.disabled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:
          MyButtonUI(text: this.text, icon: this.icon, disabled: this.disabled),
    );
  }
}
