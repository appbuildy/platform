import 'package:flutter/widgets.dart';

class MyColors {
  static const Color black = const Color(0xFF111111);
  static const Color white = const Color(0xFFFFFFFF);
  static Color iconGray = const Color(0xFF7f89a1).withOpacity(0.5);
  static const Color gray = const Color(0xFFD8D8D8);
  static const Color lightGray = const Color(0xFFE7E8ED);
  static const Color mainBlue = const Color(0xFF239dff);
  static const Color textBlue = const Color(0xFF007aff);
}

//75a2bc
class MyGradients {
  static LinearGradient transparent = LinearGradient(
    begin: AlignmentDirectional.topCenter,
    end: AlignmentDirectional.bottomCenter,
    colors: [
      Color(0xFFFFFFFF).withOpacity(0),
      Color(0xFFFFFFFF).withOpacity(0)
    ],
  );

  static LinearGradient plainWhite = LinearGradient(
    begin: AlignmentDirectional.topCenter,
    end: AlignmentDirectional.bottomCenter,
    colors: [Color(0xFFFFFFFF), Color(0xFFFFFFFF)],
  );

  static LinearGradient lightGray = LinearGradient(
    begin: AlignmentDirectional.topCenter,
    end: AlignmentDirectional.bottomCenter,
    colors: [
      Color(0xFFB1E7F2).withOpacity(0.3),
      Color(0xFF75A2BC).withOpacity(0.35)
    ],
  );

  static LinearGradient mediumBlue = LinearGradient(
    begin: AlignmentDirectional.topCenter,
    end: AlignmentDirectional.bottomCenter,
    colors: [
      Color(0xFF61E4FF).withOpacity(0.3),
      Color(0xFF00A0FF).withOpacity(0.35)
    ],
  );

  static LinearGradient lightBlue = LinearGradient(
    begin: AlignmentDirectional.topCenter,
    end: AlignmentDirectional.bottomCenter,
    colors: [Color(0xFFe9fbff), Color(0xFFc5eaff)],
  );

  static LinearGradient mainBlue = LinearGradient(
    begin: AlignmentDirectional.topCenter,
    end: AlignmentDirectional.bottomCenter,
    colors: [Color(0xFF00b1ff), Color(0xFF0077f5)],
  );
}

class MyTextStyle {
  static TextStyle regularTitle = TextStyle(
    color: MyColors.black,
    fontSize: 16,
  );

  static TextStyle mediumTitle = TextStyle(
      color: MyColors.black, fontSize: 16, fontWeight: FontWeight.w500);
}
