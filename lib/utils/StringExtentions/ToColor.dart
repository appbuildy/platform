

import 'dart:ui';

extension StringExtention on String {
  /// converts string to [Color]
  /// fill incomplete values with 0
  /// ex: 'ff00'.toColor() => Color(0xffff0000)
  Color toColor({bool argb = false}) {
    final colorString = '0x${argb ? '' : 'ff'}$this'.padRight(10, '0');
    return Color(int.tryParse(colorString) ?? 0);
  }
}