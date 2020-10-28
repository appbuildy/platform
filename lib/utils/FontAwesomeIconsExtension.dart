import 'package:flutter/cupertino.dart';

extension JsonSerializationIconData on IconData {
  static IconData fromJson(Map<String, dynamic> jsonValue) {
    final int iconDataCodePoint = int.parse(jsonValue['codePoint'].toString());
    final String iconDataFontFamily = jsonValue['fontFamily'];
    final String iconDataFontPackage = jsonValue['fontPackage'];
    final bool iconDataMatchTextDirection = jsonValue['matchTextDirection'];
    return IconData(
      iconDataCodePoint,
      fontFamily: iconDataFontFamily,
      fontPackage: iconDataFontPackage,
      matchTextDirection: iconDataMatchTextDirection,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'codePoint': codePoint,
      'fontFamily': fontFamily,
      'fontPackage': fontPackage,
      'matchTextDirection': matchTextDirection,
    };
  }
}
