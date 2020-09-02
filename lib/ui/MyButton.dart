import 'package:flutter/material.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_app/ui/HoverDecoration.dart';
import 'package:flutter_app/ui/MyColors.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Widget icon;
  final Function onTap;

  const MyButton({Key key, @required this.text, this.icon, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultDecoration = BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        gradient: MyGradients.mainBlue,
        boxShadow: []);
    final hoverDecoration = BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        gradient: MyGradients.mainBlue,
        boxShadow: [
//          BoxShadow(
//              spreadRadius: 5,
//              blurRadius: 10,
//              offset: Offset(0, 2),
//              color: MyColors.black.withOpacity(0.15))
        ]);

    return GestureDetector(
      onTap: onTap,
      child: Cursor(
        cursor: CursorEnum.pointer,
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
                    text,
                    style: TextStyle(
                        color: MyColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                icon != null
                    ? Positioned(
                        left: 13,
                        top: 1,
                        child: Center(child: icon),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
