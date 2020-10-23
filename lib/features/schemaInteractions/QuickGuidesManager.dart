import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:core';

import 'Guideliner/PositionAndSize.dart';

enum PositionTypes { start, center, end }
enum OrientationTypes { horizontal, vertical }

class Guideline {
  double axisPosition;
  OrientationTypes orientation;
  PositionTypes type;

  Guideline({
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
}

class FoundGuideline {
  Guideline guideline;
  PositionTypes foundByPositionType;
  double deltaFromObjectToGuideline;

  FoundGuideline({
    @required this.guideline,
    @required this.foundByPositionType,
    @required this.deltaFromObjectToGuideline,
  });

  @override
  String toString() {
    return '{ guideline: $guideline, foundByType: $foundByPositionType, deltaFromObjectToGuideline: $deltaFromObjectToGuideline }';
  }
}

class GuideLines {
  Guideline start;
  Guideline center;
  Guideline end;

  GuideLines({
    @required this.start,
    @required this.center,
    @required this.end,
  });

  GuideLines.fromPositionAndSize({
    @required double start,
    @required double size,
    @required OrientationTypes orientation,
  }) {
    this.start = Guideline(
      axisPosition: start,
      orientation: orientation,
      type: PositionTypes.start,
    );
    this.end = Guideline(
      axisPosition: this.start.axisPosition + size,
      orientation: orientation,
      type: PositionTypes.end,
    );
    this.center = Guideline(
      axisPosition: this.start.axisPosition + (this.end.axisPosition - this.start.axisPosition) / 2,
      orientation: orientation,
      type: PositionTypes.center,
    );
  }

  FoundGuideline findNearestGuideLineByPosition({
    @required double position,
    @required PositionTypes positionType,
    @required double magnetZone,
  }) {
    FoundGuideline foundGuideline;

    final double startDelta = (this.start.axisPosition.abs() - position.abs()).abs().roundToDouble();
    final double centerDelta = (this.center.axisPosition.abs() - position.abs()).abs().roundToDouble();
    final double endDelta = (this.end.axisPosition.abs() - position.abs()).abs().roundToDouble();

    if (
      startDelta <= magnetZone
      && startDelta < centerDelta
      && startDelta < endDelta
    ) {
      foundGuideline = FoundGuideline(
        guideline: this.start,
        foundByPositionType: positionType,
        deltaFromObjectToGuideline: startDelta,
      );
    }

    if (
      centerDelta <= magnetZone
      && centerDelta < startDelta
      && centerDelta < endDelta
    ) {
      foundGuideline = FoundGuideline(
        guideline: this.center,
        foundByPositionType: positionType,
        deltaFromObjectToGuideline: centerDelta,
      );
    }

    if (
      endDelta <= magnetZone
      && endDelta < startDelta
      && endDelta < centerDelta
    ) {
      foundGuideline = FoundGuideline(
        guideline: this.end,
        foundByPositionType: positionType,
        deltaFromObjectToGuideline: endDelta,
      );
    }

    return foundGuideline;
  }

  FoundGuideline findNearestGuideLine({double start, double size, double magnetZone}) {
    final double end = start + size;
    final double center = start + (end - start) / 2;

    final FoundGuideline startGuideline = this.findNearestGuideLineByPosition(position: start, magnetZone: magnetZone, positionType: PositionTypes.start);
    final FoundGuideline centerGuideline = this.findNearestGuideLineByPosition(position: center, magnetZone: magnetZone, positionType: PositionTypes.center);
    final FoundGuideline endGuideline = this.findNearestGuideLineByPosition(position: end, magnetZone: magnetZone, positionType: PositionTypes.end);

    if (
      startGuideline != null
      && (centerGuideline == null || startGuideline.deltaFromObjectToGuideline <= centerGuideline.deltaFromObjectToGuideline)
      && (endGuideline == null || startGuideline.deltaFromObjectToGuideline <= endGuideline.deltaFromObjectToGuideline)
    ) {
      return startGuideline;
    }

    if (
      centerGuideline != null
      && (startGuideline == null || centerGuideline.deltaFromObjectToGuideline <= startGuideline.deltaFromObjectToGuideline)
      && (endGuideline == null || centerGuideline.deltaFromObjectToGuideline <= endGuideline.deltaFromObjectToGuideline)
    ) {
      return centerGuideline;
    }

    if (
     endGuideline != null
      && (startGuideline == null || endGuideline.deltaFromObjectToGuideline <= startGuideline.deltaFromObjectToGuideline)
      && (centerGuideline == null || endGuideline.deltaFromObjectToGuideline <= centerGuideline.deltaFromObjectToGuideline)
    ) {
      return endGuideline;
    }

    return null;
  }

  @override
  String toString() {
    return '{ start: $start, center: $center, end: $end }';
  }

  List<Widget> buildAllLines({
    @required Offset screenSize,
    bool vertical = false
  }) {

    return [
      start.buildLine(screenSize: screenSize),
      center.buildLine(screenSize: screenSize),
      end.buildLine(screenSize: screenSize),
    ].toList();
  }
}

class ObjectGuides {
  UniqueKey id;
  GuideLines horizontalGuides;
  GuideLines verticalGuides;

  double magnetZone = 8;

  ObjectGuides({
    @required this.id,
    @required this.horizontalGuides,
    @required this.verticalGuides,
  });

  ObjectGuides.fromPositionAndSize(PositionAndSize object) {
    this.id = object.id;
    this.horizontalGuides = GuideLines.fromPositionAndSize(
      start: object.position.dy,
      size: object.size.dy,
      orientation: OrientationTypes.horizontal,
    );
    this.verticalGuides = GuideLines.fromPositionAndSize(
      start: object.position.dx,
      size: object.size.dx,
      orientation: OrientationTypes.vertical,
    );
  }

  @override
  String toString() {
    return '{ horizontalGuides: ${horizontalGuides.toString()}, verticalGuides: ${verticalGuides.toString()} }';
  }

  FoundGuideline findNearestGuideLineByOrientation({
    @required PositionAndSize targetObject,
    @required OrientationTypes orientation,
  }) {
    FoundGuideline foundGuideLine;

    if (orientation == OrientationTypes.horizontal) {
      foundGuideLine = horizontalGuides.findNearestGuideLine(start: targetObject.position.dy, size: targetObject.size.dy, magnetZone: this.magnetZone);
    } else {
      foundGuideLine = verticalGuides.findNearestGuideLine(start: targetObject.position.dx, size: targetObject.size.dx, magnetZone: this.magnetZone);
    }

    return foundGuideLine;
  }

  List<Widget> buildAllLines({ @required Offset screenSize }) {

    return [
      ...verticalGuides.buildAllLines(screenSize: screenSize),
      ...horizontalGuides.buildAllLines(screenSize: screenSize),
    ].toList();
  }
}

class QuickGuideManager {
  List<ObjectGuides> allObjectGuides;

  FoundGuideline horizontalGuideLine;
  FoundGuideline verticalGuideLine;

  void clearVisibleGuidelines() {
    horizontalGuideLine = null;
    verticalGuideLine = null;
  }

  void makeAllObjectGuides(List<PositionAndSize> objects) {
    this.allObjectGuides = objects.map((PositionAndSize object) {
      return ObjectGuides.fromPositionAndSize(object);
    }).toList();
  }

  void searchNearestGuides(PositionAndSize targetObject) {
    this.clearVisibleGuidelines();

    List<FoundGuideline> horizontalGuidesInMagnetZone = [];
    List<FoundGuideline> verticalGuidesInMagnetZone = [];

    this.allObjectGuides.forEach((ObjectGuides object) {
      final FoundGuideline nearestHorizontalGuideLine = object.findNearestGuideLineByOrientation(
        targetObject: targetObject,
        orientation: OrientationTypes.horizontal,
      );

      final FoundGuideline nearestVerticalGuideLine = object.findNearestGuideLineByOrientation(
        targetObject: targetObject,
        orientation: OrientationTypes.vertical,
      );

      if (nearestHorizontalGuideLine != null) horizontalGuidesInMagnetZone.add(nearestHorizontalGuideLine);

      if (nearestVerticalGuideLine != null) verticalGuidesInMagnetZone.add(nearestVerticalGuideLine);
    });

    if (horizontalGuidesInMagnetZone.isNotEmpty) {
      horizontalGuidesInMagnetZone.sort((a, b) => a.deltaFromObjectToGuideline.compareTo(b.deltaFromObjectToGuideline));

      this.horizontalGuideLine = horizontalGuidesInMagnetZone[0];
    }

    if (verticalGuidesInMagnetZone.isNotEmpty) {
      verticalGuidesInMagnetZone.sort((a, b) => a.deltaFromObjectToGuideline.compareTo(b.deltaFromObjectToGuideline));

      this.verticalGuideLine = verticalGuidesInMagnetZone[0];
    }
  }

  List<Widget> buildAllLines({ @required Offset screenSize }) {
    if (allObjectGuides == null) return [Container()];

    return allObjectGuides.map((ObjectGuides object) => object.buildAllLines(screenSize: screenSize)).expand((element) => element).toList();
  }

  List<Widget> buildMagnetLines({ @required Offset screenSize }) {

    return [
      this.horizontalGuideLine?.guideline?.buildLine(screenSize: screenSize) ?? Container(),
      this.verticalGuideLine?.guideline?.buildLine(screenSize: screenSize) ?? Container(),
    ];
  }
}