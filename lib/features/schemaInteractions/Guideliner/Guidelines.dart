import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:core';

import 'FoundGuidelines.dart';
import 'PositionAndSize.dart';
import 'Rays.dart';

enum PositionTypes { start, center, end }
enum OrientationTypes { horizontal, vertical }
enum MoveDirections { forward, backward }

class FoundGuideline {
  Ray guideline;
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

class AxisRays {
  Ray start;
  Ray center;
  Ray end;

  AxisRays({
    @required this.start,
    @required this.center,
    @required this.end,
  });

  AxisRays.fromPositionAndSize({
    @required double start,
    @required double size,
    @required OrientationTypes orientation,
  }) {
    this.start = Ray(
      axisPosition: start,
      orientation: orientation,
      positionType: PositionTypes.start,
    );
    this.end = Ray(
      axisPosition: this.start.axisPosition + size,
      orientation: orientation,
      positionType: PositionTypes.end,
    );
    this.center = Ray(
      axisPosition: this.start.axisPosition + (this.end.axisPosition - this.start.axisPosition) / 2,
      orientation: orientation,
      positionType: PositionTypes.center,
    );
  }

  List<Ray> toRayList() {
    return [this.start, this.center, this.end];
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
  AxisRays horizontalGuides;
  AxisRays verticalGuides;

  ObjectGuides({
    @required this.id,
    @required this.horizontalGuides,
    @required this.verticalGuides,
  });

  ObjectGuides.fromPositionAndSize(PositionAndSize object) {
    this.id = object.id;
    this.horizontalGuides = AxisRays.fromPositionAndSize(
      start: object.position.dy,
      size: object.size.dy,
      orientation: OrientationTypes.horizontal,
    );
    this.verticalGuides = AxisRays.fromPositionAndSize(
      start: object.position.dx,
      size: object.size.dx,
      orientation: OrientationTypes.vertical,
    );
  }

  @override
  String toString() {
    return '{ horizontalGuides: ${horizontalGuides.toString()}, verticalGuides: ${verticalGuides.toString()} }';
  }

  FoundGuideline searchNearestOnDirectionGuideline({
    @required List<Ray> rays,
    @required MoveDirections direction,
    @required double magnetZone,
    @required AxisRays existingRays,
  }) {
    List<FoundGuideline> foundGuidelines = [];

    existingRays.toRayList().forEach((Ray existingRay) {
      rays.forEach((Ray compareRay) {

        final isOnDirection = direction == MoveDirections.forward
            ? existingRay.axisPosition >= compareRay.axisPosition
            : existingRay.axisPosition <= compareRay.axisPosition;

        if (isOnDirection) {
          final double delta = (existingRay.axisPosition.abs() - compareRay.axisPosition.abs()).abs();

          if (delta <= magnetZone) {
            foundGuidelines.add(
              FoundGuideline(
                guideline: existingRay,
                foundByPositionType: compareRay.positionType,
                deltaFromObjectToGuideline: delta,
              )
            );
          }
        }
      });
    });

    if (foundGuidelines.isNotEmpty) {
      foundGuidelines.sort((a, b) => a.deltaFromObjectToGuideline.compareTo(b.deltaFromObjectToGuideline));
      return foundGuidelines[0];
    }

    return null;
  }

  FoundGuideline searchNearestHorizontalOnDirectionGuidelineFromRays({
    @required List<Ray> rays,
    @required MoveDirections direction,
    @required double magnetZone,
  }) {
    return this.searchNearestOnDirectionGuideline(
        rays: rays,
        direction: direction,
        magnetZone: magnetZone,
        existingRays: this.horizontalGuides,
    );
  }

  FoundGuideline searchNearestVerticalOnDirectionGuidelineFromRays({
    @required List<Ray> rays,
    @required MoveDirections direction,
    @required double magnetZone,
  }) {
    return this.searchNearestOnDirectionGuideline(
      rays: rays,
      direction: direction,
      magnetZone: magnetZone,
      existingRays: this.verticalGuides,
    );
  }

  List<Widget> buildAllLines({ @required Offset screenSize }) {

    return [
      ...verticalGuides.buildAllLines(screenSize: screenSize),
      ...horizontalGuides.buildAllLines(screenSize: screenSize),
    ].toList();
  }
}

class Guidelines {
  List<ObjectGuides> allObjectGuides = [];

  double magnetZone = 8;

  FoundGuidelines foundGuidelines = FoundGuidelines();

  void makeAllObjectGuides(List<PositionAndSize> objects) {
    this.allObjectGuides = objects.map((PositionAndSize object) {
      return ObjectGuides.fromPositionAndSize(object);
    }).toList();
  }

  void searchNearestHorizontalOnDirectionGuidelineFromRays({
    @required List<Ray> rays,
    @required MoveDirections direction,
  }) {
    this.foundGuidelines.clearHorizontal();

    if (rays == null || rays.isEmpty) return;

    List<FoundGuideline> foundGuidelines = [];

    this.allObjectGuides.forEach((ObjectGuides object) {
      FoundGuideline foundGuideline = object
        .searchNearestHorizontalOnDirectionGuidelineFromRays(
          rays: rays,
          direction: direction,
          magnetZone: this.magnetZone,
      );

      if (foundGuideline != null)
        foundGuidelines.add(foundGuideline);
    });


    if (foundGuidelines.isNotEmpty) {
      foundGuidelines.sort((a, b) => a.deltaFromObjectToGuideline.compareTo(b.deltaFromObjectToGuideline));
      this.foundGuidelines.setHorizontal(foundGuidelines[0]);
    }
  }

  void searchNearestVerticalOnDirectionGuidelineFromRays({ @required List<Ray> rays, @required MoveDirections direction}) {
    this.foundGuidelines.clearVertical();

    if (rays == null || rays.isEmpty) return;

    List<FoundGuideline> foundGuidelines = [];

    this.allObjectGuides.forEach((ObjectGuides object) {
      FoundGuideline foundGuideline = object
        .searchNearestVerticalOnDirectionGuidelineFromRays(
          rays: rays,
          direction: direction,
          magnetZone: this.magnetZone,
      );

      if (foundGuideline != null)
        foundGuidelines.add(foundGuideline);
    });


    if (foundGuidelines.isNotEmpty) {
      foundGuidelines.sort((a, b) => a.deltaFromObjectToGuideline.compareTo(b.deltaFromObjectToGuideline));
      this.foundGuidelines.setVertical(foundGuidelines[0]);
    }
  }

  List<Widget> buildAllLines({ @required Offset screenSize }) {
    if (allObjectGuides == null) return [Container()];

    return allObjectGuides.map(
            (ObjectGuides object) => object.buildAllLines(screenSize: screenSize)
    ).expand((element) => element).toList();
  }

  List<Widget> buildMagnetLines({ @required Offset screenSize }) {
    return this.foundGuidelines.toWidgets(screenSize: screenSize);
  }
}