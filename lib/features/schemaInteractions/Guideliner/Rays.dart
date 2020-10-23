import 'package:flutter/material.dart';

import 'Guidelines.dart';

class Ray {
  double axisPosition;
  OrientationTypes orientation;
  PositionTypes type;

  Ray({
    @required this.axisPosition,
    @required this.orientation,
    @required this.type,
  });

  @override
  String toString() {
    return '{ position: $axisPosition, orientation: $orientation, type: $type }';
  }

  Widget buildLine({ @required Offset screenSize }) {
    final bool isVertical = this.orientation == OrientationTypes.vertical;

    final width = isVertical ? 1 : screenSize.dx;
    final height = isVertical ? screenSize.dy : 1;

    return (
        Positioned(
          top: isVertical ? 0 : this.axisPosition,
          left: isVertical ? this.axisPosition : 0,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Color(0xFFFF6666),
            ),
          ),
        )
    );
  }

  static Map<PositionTypes, Ray> getRays({ @required double position, @required double size }) {

  }
}