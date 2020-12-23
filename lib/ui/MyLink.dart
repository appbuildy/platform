// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

import 'package:flutter/material.dart';
import 'package:flutter_app/config/colors.dart';

import 'Cursor.dart';

class MyLink extends StatelessWidget {
  final TextStyle style;
  final String text;
  final String href;

  const MyLink({Key key, this.style, @required this.text, @required this.href})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Cursor(
      cursor: CursorEnum.pointer,
      child: GestureDetector(
        onTap: () {
          js.context.callMethod('open', [href]);
        },
        child: Text(text,
            style: style ??
                TextStyle(
                    color: MyColors.textBlue,
                    fontSize: 16,
                    fontWeight: FontWeight.w600)),
      ),
    );
  }
}
