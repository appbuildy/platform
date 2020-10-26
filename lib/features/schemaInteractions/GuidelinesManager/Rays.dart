import 'package:flutter/material.dart';

import 'GuidelinesManager.dart';

class Ray {
  double axisPosition;
  OrientationTypes orientation;
  OnObjectPositionTypes onObjectPositionType;
  bool isVisible = false;

  Ray({
    @required this.axisPosition,
    @required this.orientation,
    @required this.onObjectPositionType,
  });

  @override
  String toString() {
    return '{ position: $axisPosition, orientation: $orientation, type: $onObjectPositionType }';
  }

  Widget buildLine({ @required Offset screenSize }) {
    final bool isVertical = this.orientation == OrientationTypes.vertical;

    final width = isVertical ? 1 : screenSize.dx;
    final height = isVertical ? screenSize.dy : 1;

    return this.isVisible ? (
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
    ) : Container();
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
          onObjectPositionType: OnObjectPositionTypes.start),
      Ray(axisPosition: center,
          orientation: raysOrientation,
          onObjectPositionType: OnObjectPositionTypes.center),
      Ray(axisPosition: end,
          orientation: raysOrientation,
          onObjectPositionType: OnObjectPositionTypes.end),
    ];
  }
}