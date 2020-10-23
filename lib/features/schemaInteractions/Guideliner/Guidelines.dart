import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:core';

import 'FoundGuidelines.dart';
import 'PositionAndSize.dart';
import 'Rays.dart';

enum PositionTypes { start, center, end }
enum OrientationTypes { horizontal, vertical }
enum Directions { forward, backward }

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

class GuideLines {
  Ray start;
  Ray center;
  Ray end;

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
    this.start = Ray(
      axisPosition: start,
      orientation: orientation,
      type: PositionTypes.start,
    );
    this.end = Ray(
      axisPosition: this.start.axisPosition + size,
      orientation: orientation,
      type: PositionTypes.end,
    );
    this.center = Ray(
      axisPosition: this.start.axisPosition + (this.end.axisPosition - this.start.axisPosition) / 2,
      orientation: orientation,
      type: PositionTypes.center,
    );
  }

  List<Ray> toRays() {
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

  FoundGuideline searchNearestHorizontalOnDirectionGuidelineFromRays({
    @required List<Ray> rays,
    @required Directions direction
  }) {
    List<FoundGuideline> foundGuidelines = [];

    this.horizontalGuides.toRays().forEach((Ray existingRay) {
      rays.forEach((Ray compareRay) {

      });
    });

    if (foundGuidelines.isNotEmpty) {
      return foundGuidelines[0];
    }

    return null;
  }

  FoundGuideline searchNearestVerticalOnDirectionGuidelineFromRays({
    @required List<Ray> rays,
    @required Directions direction
  }) {
    List<FoundGuideline> foundGuidelines = [];

    this.verticalGuides.toRays().forEach((Ray existingRay) {
      rays.forEach((Ray compareRay) {

      });
    });

    if (foundGuidelines.isNotEmpty) {
      return foundGuidelines[0];
    }

    return null;
  }

  List<Widget> buildAllLines({ @required Offset screenSize }) {

    return [
      ...verticalGuides.buildAllLines(screenSize: screenSize),
      ...horizontalGuides.buildAllLines(screenSize: screenSize),
    ].toList();
  }
}

class Guidelines {
  List<ObjectGuides> allObjectGuides;

  FoundGuidelines foundGuidelines = FoundGuidelines();

  void makeAllObjectGuides(List<PositionAndSize> objects) {
    this.allObjectGuides = objects.map((PositionAndSize object) {
      return ObjectGuides.fromPositionAndSize(object);
    }).toList();
  }

  void searchNearestHorizontalOnDirectionGuidelineFromRays(List<Ray> rays, Directions direction) {
    this.foundGuidelines.clearHorizontal();

    if (rays == null || rays.isEmpty) return;

    List<FoundGuideline> foundGuidelines = [];

    this.allObjectGuides.forEach((ObjectGuides object) {
      FoundGuideline foundGuideline = object
          .searchNearestHorizontalOnDirectionGuidelineFromRays(rays: rays, direction: direction);

      if (foundGuideline != null)
        foundGuidelines.add(foundGuideline);
    });
  }

  void searchNearestVerticalOnDirectionGuidelineFromRays(List<Ray> rays, Directions direction) {
    this.foundGuidelines.clearVertical();

    if (rays == null || rays.isEmpty) return;

    List<FoundGuideline> foundGuidelines = [];

    this.allObjectGuides.forEach((ObjectGuides object) {
      FoundGuideline foundGuideline = object
          .searchNearestVerticalOnDirectionGuidelineFromRays(rays: rays, direction: direction);

      if (foundGuideline != null)
        foundGuidelines.add(foundGuideline);
    });
  }

  List<Widget> buildAllLines({ @required Offset screenSize }) {
    if (allObjectGuides == null) return [Container()];

    return allObjectGuides.map((ObjectGuides object) => object.buildAllLines(screenSize: screenSize)).expand((element) => element).toList();
  }

  List<Widget> buildMagnetLines({ @required Offset screenSize }) {
    return this.foundGuidelines.toWidgets(screenSize: screenSize);
  }
}