import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

extension JsonSerializationIconData on IconData {
  static IconData fromJson(Map<String, dynamic> val) {
    switch (val['class']) {
      case 'IconDataBrands':
        {
          return IconDataBrands(val['codePoint']);
        }
        break;

      case 'IconDataSolid':
        {
          return IconDataSolid(val['codePoint']);
        }
        break;

      case 'IconDataRegular':
        {
          return IconDataRegular(val['codePoint']);
        }
        break;

      default:
        {
          return IconData(val['codePoint']);
        }
        break;
    }
  }

  Map<String, dynamic> toJson() {
    return {'codePoint': this.codePoint, 'class': runtimeType.toString()};
  }
}
