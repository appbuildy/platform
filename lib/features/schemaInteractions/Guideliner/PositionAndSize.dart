import 'package:flutter/material.dart';

class PositionAndSize {
  UniqueKey id;
  Offset position;
  Offset size;

  PositionAndSize({
    @required this.id,
    @required this.position,
    @required this.size,
  });

  @override
  String toString() {
    return '{ position: $position, size: $size }';
  }
}