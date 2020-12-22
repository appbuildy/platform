import 'package:flutter/material.dart';

import 'colors.dart';

class MyTextStyle {
  static TextStyle regularTitle = TextStyle(
    color: MyColors.black,
    fontSize: 16,
    height: 20 / 16,
  );

  static TextStyle regularTitleWhite = TextStyle(
    color: MyColors.white,
    fontSize: 16,
  );

  static TextStyle giantTitle = TextStyle(
      color: MyColors.black, fontSize: 36, fontWeight: FontWeight.w600);

  static TextStyle mediumTitle = TextStyle(
      color: MyColors.black, fontSize: 16, fontWeight: FontWeight.w500);

  static TextStyle mediumTitleWhite = TextStyle(
      color: MyColors.white, fontSize: 16, fontWeight: FontWeight.w500);

  static TextStyle regularCaption =
      TextStyle(color: Color(0xFF777777), fontSize: 14);
}
