import 'package:flutter_app/utils/StringExtentions/CapitalizeString.dart';

extension StringExtension on String {
  String toNormalCapitalizedString() {
    if (this.length == 0) return '';
    return this.split(RegExp(r"\s+|_")).map((String word) => word.capitalize()).join(' ');
  }
}
