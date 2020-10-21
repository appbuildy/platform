import 'dart:ui';
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
    return '''{ position: $position, size: $size }''';
  }
}

class AxisGuides {
  double start;
  double center;
  double end;

  AxisGuides({
    @required this.start,
    @required this.center,
    @required this.end,
  });

  AxisGuides.fromObjectConstrains({
    @required double start,
    @required double size,
  }) {
    this.start = start;
    this.end = this.start + size;
    this.center = this.start + (this.end - this.start) / 2;
  }

  @override
  String toString() {
    return '''{ start: $start, center: $center, end: $end }''';
  }

  List<Widget> buildLines({
    @required Offset screenSize,
    bool vertical = false
  }) {
    final width = vertical ? 1 : screenSize.dx;
    final height = vertical ? screenSize.dy : 1;

    Widget getLine(double value) {
      return (
        Positioned(
          top: vertical ? 0 : value,
          left: vertical ? value : 0,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.red,
            ),
          ),
        )
      );
    }

    return [
      getLine(start),
      getLine(center),
      getLine(end),
    ].toList();
  }
}

class ObjectGuides {
  UniqueKey id;
  AxisGuides horizontalGuides;
  AxisGuides verticalGuides;

  ObjectGuides({
    @required this.id,
    @required this.horizontalGuides,
    @required this.verticalGuides,
  });

  ObjectGuides.fromObjectConstrains(PositionAndSize object) {
    this.id = object.id;
    this.horizontalGuides = AxisGuides.fromObjectConstrains(start: object.position.dy, size: object.size.dy);
    this.verticalGuides = AxisGuides.fromObjectConstrains(start: object.position.dx, size: object.size.dx);
  }

  @override
  String toString() {
    return '''{ horizontalGuides: ${horizontalGuides.toString()}, verticalGuides: ${verticalGuides.toString()} }''';
  }

  List<Widget> buildLines({ @required Offset screenSize }) {
    return [
      ...verticalGuides.buildLines(screenSize: screenSize, vertical: true),
      ...horizontalGuides.buildLines(screenSize: screenSize),
    ].toList();
  }
}

class QuickGuideManager {
  List<ObjectGuides> objects;

  void buildQuickGuides(List<PositionAndSize> objects) {
    this.objects = objects.map((PositionAndSize object) {
      return ObjectGuides.fromObjectConstrains(object);
    }).toList();
  }

  List<Widget> buildLines({ @required Offset screenSize }) {
    if (objects == null) return [Container()];

    return objects.map((ObjectGuides object) => object.buildLines(screenSize: screenSize)).expand((element) => element).toList();
  }
}