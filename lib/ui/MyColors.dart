import 'package:flutter/widgets.dart';

class MyColors {
  static const Color black = const Color(0xFF111111);
  static const Color white = const Color(0xFFFFFFFF);
  static const Color mainBlue = const Color(0xFF239dff);
  static const Color textBlue = const Color(0xFF007aff);

//  static const Color mainBlue = const Color(0xFF239dff);
}

//75a2bc
class MyGradients {
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

  static LinearGradient lightBlue = LinearGradient(
    begin: AlignmentDirectional.topCenter,
    end: AlignmentDirectional.bottomCenter,
    colors: [
      Color(0xFF61E4FF).withOpacity(0.3),
      Color(0xFF00A0FF).withOpacity(0.35)
    ],
  );
}
