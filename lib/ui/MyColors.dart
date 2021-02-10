import 'package:flutter/widgets.dart';

class MyColors {
  static const Color black = const Color(0xFF111111);
  static const Color white = const Color(0xFFFFFFFF);
  static Color iconGray = const Color(0xFF7f89a1).withOpacity(0.5);
  static Color iconDarkGray = const Color(0xFF7f89a1);
  static Color borderGray = const Color(0xFF787878).withOpacity(0.35);
  static const Color gray = const Color(0xFFD8D8D8);
  static const Color lightGray = const Color(0xFFE7E8ED);
  static const Color mainBlue = const Color(0xFF239dff);
  static const Color textBlue = const Color(0xFF007aff);
  static const Color error = const Color(0xFFff3e3e);
}

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

  static LinearGradient buttonLightGray = LinearGradient(
    begin: AlignmentDirectional.topCenter,
    end: AlignmentDirectional.bottomCenter,
    colors: [Color(0xFFFFFFFF), Color(0xFFf1f2f9)],
  );

  static LinearGradient buttonDisabledGray = LinearGradient(
    begin: AlignmentDirectional.topCenter,
    end: AlignmentDirectional.bottomCenter,
    colors: [Color(0xFFf2f3f7), Color(0xFFf2f3f7)],
  );

  static LinearGradient buttonLightBlue = LinearGradient(
    begin: AlignmentDirectional.topCenter,
    end: AlignmentDirectional.bottomCenter,
    colors: [Color(0xFFFFFFFF), Color(0xFFddf3ff)],
  );

  static LinearGradient buttonLightWhite = LinearGradient(
    begin: AlignmentDirectional.topCenter,
    end: AlignmentDirectional.bottomCenter,
    colors: [Color(0xFFFFFFFF), Color(0xFFfafbff)],
  );

  static LinearGradient lightGray = LinearGradient(
    begin: AlignmentDirectional.topCenter,
    end: AlignmentDirectional.bottomCenter,
    colors: [
      Color(0xFFB1E7F2).withOpacity(0.3),
      Color(0xFF75A2BC).withOpacity(0.35)
    ],
  );

  static LinearGradient disabledLightGray = LinearGradient(
      begin: AlignmentDirectional.topCenter,
      end: AlignmentDirectional.bottomCenter,
      colors: [
        Color(0xFFB1E7F2).withOpacity(0.8),
        Color(0xFF75A2BC).withOpacity(0.65)
      ]);

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

  static LinearGradient mainSuperLight = LinearGradient(
    begin: AlignmentDirectional.topCenter,
    end: AlignmentDirectional.bottomCenter,
    colors: [
      Color(0xFF61e5ff).withOpacity(0.3),
      Color(0xFF00a2ff).withOpacity(0.35)
    ],
  );

  static LinearGradient mainBlue = LinearGradient(
    begin: AlignmentDirectional.topCenter,
    end: AlignmentDirectional.bottomCenter,
    colors: [Color(0xFF00b1ff), Color(0xFF0077f5)],
  );

  static LinearGradient mainLightBlue = LinearGradient(
    begin: AlignmentDirectional.topCenter,
    end: AlignmentDirectional.bottomCenter,
    colors: [Color(0xFF22bdff), Color(0xFF0089ff)],
  );
}

class MyTextStyle {
  static TextStyle regularTitle = TextStyle(
    color: MyColors.black,
    fontSize: 16,
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
