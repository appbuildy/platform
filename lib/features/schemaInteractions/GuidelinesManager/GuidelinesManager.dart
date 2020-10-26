import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:core';

import 'FoundGuidelines.dart';
import 'PositionAndSize.dart';
import 'Rays.dart';

enum OnObjectPositionTypes { start, center, end }
enum OrientationTypes { horizontal, vertical }
enum MoveDirections { forward, backward }

class FoundGuideline {
  Ray guideline;
  OnObjectPositionTypes foundByPositionType;
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
      onObjectPositionType: OnObjectPositionTypes.start,
    );
    this.end = Ray(
      axisPosition: this.start.axisPosition + size,
      orientation: orientation,
      onObjectPositionType: OnObjectPositionTypes.end,
    );
    this.center = Ray(
      axisPosition: this.start.axisPosition + (this.end.axisPosition - this.start.axisPosition) / 2,
      orientation: orientation,
      onObjectPositionType: OnObjectPositionTypes.center,
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

  List<Widget> buildAllLines({ @required Offset screenSize }) {

    return [
      ...verticalGuides.buildAllLines(screenSize: screenSize),
      ...horizontalGuides.buildAllLines(screenSize: screenSize),
    ].toList();
  }
}

class GuidelinesManager {
  List<ObjectGuides> allObjectGuides = [];

  double magnetZone = 4;

  FoundGuidelines foundGuidelines = FoundGuidelines();

  void makeAllObjectGuides(List<PositionAndSize> objects) {
    this.allObjectGuides = objects.map((PositionAndSize object) {
      return ObjectGuides.fromPositionAndSize(object);
    }).toList();
  }

  List<FoundGuideline> _searchNearestOnDirectionGuidelines({
    @required List<Ray> rays,
    @required existingRays,
    @required MoveDirections direction,
  }) {
    List<FoundGuideline> foundGuidelines = [];

    existingRays.forEach((Ray existingRay) {
      rays.forEach((Ray compareRay) {
        final isOnDirection = direction == MoveDirections.forward
            ? existingRay.axisPosition >= compareRay.axisPosition
            : existingRay.axisPosition <= compareRay.axisPosition;

        if (isOnDirection) {
          final double delta = (existingRay.axisPosition.abs() -
              compareRay.axisPosition.abs()).abs();

          if (delta <= magnetZone) {
            existingRay.positionCorrection = compareRay.onObjectPositionType == OnObjectPositionTypes.end ? -1 : 0;
            foundGuidelines.add(
                FoundGuideline(
                  guideline: existingRay,
                  foundByPositionType: compareRay.onObjectPositionType,
                  deltaFromObjectToGuideline: delta,
                )
            );
          }
        }
      });
    });

    return foundGuidelines;
  }

  void searchNearestHorizontalOnDirectionGuidelineFromRays({
    @required List<Ray> rays,
    @required MoveDirections direction,
  }) {
    this.clearHorizontal();

    if (rays == null || rays.isEmpty) return;

    List<Ray> allRays = [];

    this.allObjectGuides.forEach((ObjectGuides object) {
      allRays.addAll(object.horizontalGuides.toRayList());
    });

    if (allRays.isEmpty) return;

    List<FoundGuideline> foundGuidelines = _searchNearestOnDirectionGuidelines(rays:  rays, existingRays: allRays, direction: direction);

    if (foundGuidelines.isNotEmpty) {
      foundGuidelines.sort((a, b) => a.deltaFromObjectToGuideline.compareTo(b.deltaFromObjectToGuideline));
      this.foundGuidelines.setHorizontal(foundGuidelines[0]);
      foundGuidelines[0].guideline.isVisible = true;
    }
  }

  clearHorizontal() {
    this.foundGuidelines.clearHorizontal();
    this.allObjectGuides.forEach((element) {
      element.horizontalGuides.toRayList().forEach((element) => element.isVisible = false);
    });
  }

  void clearVertical() {
    this.foundGuidelines.clearVertical();
    this.allObjectGuides.forEach((element) {
      element.verticalGuides.toRayList().forEach((element) => element.isVisible = false);
      element.verticalGuides.toRayList().forEach((element) => element.isVisible = false);
    });
  }

  void setAllInvisible() {
    this.allObjectGuides.forEach((element) {
      element.verticalGuides.toRayList().forEach((element) => element.isVisible = false);
      element.horizontalGuides.toRayList().forEach((element) => element.isVisible = false);
    });
  }

  void searchNearestVerticalOnDirectionGuidelineFromRays({ @required List<Ray> rays, @required MoveDirections direction}) {
    this.clearVertical();

    if (rays == null || rays.isEmpty) return;

    List<Ray> allRays = [];

    this.allObjectGuides.forEach((ObjectGuides object) {
      allRays.addAll(object.verticalGuides.toRayList());
    });

    if (allRays.isEmpty) return;

    List<FoundGuideline> foundGuidelines = _searchNearestOnDirectionGuidelines(rays:  rays, existingRays: allRays, direction: direction);

    if (foundGuidelines.isNotEmpty) {
      foundGuidelines.sort((a, b) => a.deltaFromObjectToGuideline.compareTo(b.deltaFromObjectToGuideline));
      this.foundGuidelines.setVertical(foundGuidelines[0]);
      foundGuidelines[0].guideline.isVisible = true;
    }
  }

  List<FoundGuideline> _searchGuidelinesUnderRays({
    @required List<Ray> rays,
    @required existingRays,
  }) {
    List<FoundGuideline> foundGuidelines = [];

    existingRays.forEach((Ray existingRay) {
      rays.forEach((Ray compareRay) {
        if (existingRay.axisPosition == compareRay.axisPosition) {
          existingRay.positionCorrection = compareRay.onObjectPositionType == OnObjectPositionTypes.end ? -1 : 0;
          foundGuidelines.add(
            FoundGuideline(
              guideline: existingRay,
              foundByPositionType: compareRay.onObjectPositionType,
              deltaFromObjectToGuideline: 0,
            )
          );
        }
      });
    });

    return foundGuidelines;
  }

  void searchGuidelinesUnderHorizontalRays({ @required List<Ray> rays }) {
    this.clearHorizontal();

    if (rays == null || rays.isEmpty) return;

    List<Ray> allRays = [];

    this.allObjectGuides.forEach((ObjectGuides object) {
      allRays.addAll(object.horizontalGuides.toRayList());
    });

    if (allRays.isEmpty) return;

    List<FoundGuideline> foundGuidelines = _searchGuidelinesUnderRays(rays: rays, existingRays: allRays);

    if (foundGuidelines.isNotEmpty) {
      this.foundGuidelines.setHorizontal(foundGuidelines[0]);
    }

    foundGuidelines.forEach((element) => element.guideline.isVisible = true);
  }

  void searchGuidelinesUnderVerticalRays({ @required List<Ray> rays }) {
    this.clearVertical();

    if (rays == null || rays.isEmpty) return;

    List<Ray> allRays = [];

    this.allObjectGuides.forEach((ObjectGuides object) {
      allRays.addAll(object.verticalGuides.toRayList());
    });

    if (allRays.isEmpty) return;

    List<FoundGuideline> foundGuidelines = _searchGuidelinesUnderRays(rays: rays, existingRays: allRays);

    if (foundGuidelines.isNotEmpty) {
      this.foundGuidelines.setVertical(foundGuidelines[0]);
    }
    foundGuidelines.forEach((element) => element.guideline.isVisible = true);
  }

  void filterVisibleRays(List<Ray> raysToFilter) {
    Map<double, bool> filterMap = {};

    raysToFilter.forEach((Ray ray) {
      if (filterMap[ray.axisPosition] == true) {
        ray.isVisible = false;
      } else {
        filterMap[ray.axisPosition] = true;
      }
    });
  }

  List<Widget> buildAllLines({ @required Offset screenSize }) {
    if (allObjectGuides == null) return [Container()];

    this.filterVisibleRays(this.allObjectGuides.map((o) => o.horizontalGuides.toRayList().toList()).expand((e) => e).toList());
    this.filterVisibleRays(this.allObjectGuides.map((o) => o.verticalGuides.toRayList().toList()).expand((e) => e).toList());

    return allObjectGuides.map(
            (ObjectGuides object) => object.buildAllLines(screenSize: screenSize)
    ).expand((element) => element).toList();
  }
}