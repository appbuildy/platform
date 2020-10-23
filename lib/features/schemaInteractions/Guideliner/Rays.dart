import 'package:flutter/material.dart';

import 'Guidelines.dart';

class Ray {
  double axisPosition;
  OrientationTypes orientation;
  PositionTypes positionType;

  Ray({
    @required this.axisPosition,
    @required this.orientation,
    @required this.positionType,
  });

  @override
  String toString() {
    return '{ position: $axisPosition, orientation: $orientation, type: $positionType }';
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

  static List<Ray> getOrientedRays({
    @required double startPosition,
    @required double objectSize,
    @required OrientationTypes raysOrientation
  }) {
    final double end = startPosition + objectSize;
    final double center = startPosition + (end - startPosition) / 2;

    return [
      Ray(axisPosition: startPosition,
          orientation: raysOrientation,
          positionType: PositionTypes.start),
      Ray(axisPosition: center,
          orientation: raysOrientation,
          positionType: PositionTypes.center),
      Ray(axisPosition: end,
          orientation: raysOrientation,
          positionType: PositionTypes.end),
    ];
  }
}