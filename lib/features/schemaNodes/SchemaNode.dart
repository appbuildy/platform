import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/GuidelinesManager/GuidelinesManager.dart';
import 'package:flutter_app/features/schemaInteractions/GuidelinesManager/Rays.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeSpawner.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/utils/DeltaPanDetector.dart';

export 'SchemaNodeButton.dart';
export 'SchemaNodeImage.dart';
export 'SchemaNodeProperty.dart';
export 'SchemaNodeShape.dart';
export 'SchemaNodeText.dart';

enum SchemaNodeType {
  button,
  text,
  shape,
  image,
  icon,
  list,
  listDefault,
  listCards
}

abstract class SchemaNode {
  UniqueKey id;
  SchemaNodeType type;
  Offset position;
  SchemaNodeSpawner parentSpawner;
  Offset size;
  Map<String, SchemaNodeProperty> properties;
  Map<String, SchemaNodeProperty> changeableProperties;
  Map<String, SchemaNodeProperty> actions;

  SchemaNode copy({
    Offset position,
    Offset size,
    UniqueKey id,
    bool saveProperties,
  });

  static double minimalSize = 30.0;

  static double demagnetizeSideDelta = 8;

  static bool canDemagnetize({FoundGuideline foundGuideline, double delta}) {
    final double absDelta = delta.abs();

    if (foundGuideline != null && absDelta < SchemaNode.demagnetizeSideDelta) {
      return false;
    }

    return true;
  }

  double axisMove({
    @required double axisNodePosition,
    @required double axisNodeSize,
    @required double axisDelta,
    @required double axisScreenSize,
  }) {
    if (axisNodePosition + axisDelta <= 0) {
      return 0;
    }

    if (axisNodePosition + axisDelta + axisNodeSize > axisScreenSize) {
      return axisScreenSize - axisNodeSize;
    }

    return axisNodePosition + axisDelta;
  }

  SchemaNode move({
    @required Offset delta,
    @required Offset screenSize,
  }) {
    this.position = Offset(
      this.axisMove(
        axisNodePosition: this.position.dx,
        axisNodeSize: this.size.dx,
        axisDelta: delta.dx,
        axisScreenSize: screenSize.dx,
      ),
      this.axisMove(
        axisNodePosition: this.position.dy,
        axisNodeSize: this.size.dy,
        axisDelta: delta.dy,
        axisScreenSize: screenSize.dy,
      ),
    );

    return this;
  }

  List<double> _resizeSideWithAnchorPoint({
    @required double position,
    @required double size,
    @required double delta,
    @required double axisScreenSize,
  }) {
    final double previousPosition = position;

    double newPosition = previousPosition + delta;

    final double movedDelta = position - newPosition;

    double newSize = size + movedDelta;

    if (newSize < SchemaNode.minimalSize) {
      final double addedSize = SchemaNode.minimalSize - newSize;

      newSize += addedSize;

      newPosition -= addedSize;
    }

    if (newSize < SchemaNode.minimalSize) {
      final double addedSize = SchemaNode.minimalSize - newSize;

      newSize += addedSize;

      newPosition -= addedSize;
    }

    if (newPosition < 0) {
      final double subtractedSize = newPosition.abs();

      newSize -= subtractedSize;

      newPosition += subtractedSize;
    }

    return [newPosition, newSize];
  }

  double _resizeSide({
    @required double position,
    @required double size,
    @required double delta,
    @required double axisScreenSize,
  }) {
    double newSize = size + delta;

    if (newSize < SchemaNode.minimalSize) {
      newSize = SchemaNode.minimalSize;
    }

    if (position + newSize > axisScreenSize) {
      newSize = axisScreenSize - position.round();
    }

    return newSize;
  }

  SchemaNode resizeTop({
    @required double deltaDy,
    @required double screenSizeDy,
  }) {
    List<double> newPositionAndSize = this._resizeSideWithAnchorPoint(
      position: this.position.dy,
      size: this.size.dy,
      delta: deltaDy,
      axisScreenSize: screenSizeDy,
    );

    final double newPosition = newPositionAndSize[0];
    this.position = Offset(
      this.position.dx,
      newPosition,
    );

    final double newSize = newPositionAndSize[1];
    this.size = Offset(
      this.size.dx,
      newSize,
    );

    return this;
  }

  SchemaNode resizeRight({
    @required double deltaDx,
    @required double screenSizeDx,
  }) {
    final newSize = this._resizeSide(
      position: this.position.dx,
      size: this.size.dx,
      delta: deltaDx,
      axisScreenSize: screenSizeDx,
    );

    this.size = Offset(
      newSize,
      this.size.dy,
    );

    return this;
  }

  SchemaNode resizeBottom({
    @required double deltaDy,
    @required double screenSizeDy,
  }) {
    final newSize = this._resizeSide(
      position: this.position.dy,
      size: this.size.dy,
      delta: deltaDy,
      axisScreenSize: screenSizeDy,
    );

    this.size = Offset(
      this.size.dx,
      newSize,
    );

    return this;
  }

  SchemaNode resizeLeft({
    @required double deltaDx,
    @required double screenSizeDx,
  }) {
    List<double> newPositionAndSize = this._resizeSideWithAnchorPoint(
      position: this.position.dx,
      size: this.size.dx,
      delta: deltaDx,
      axisScreenSize: screenSizeDx,
    );

    final double newPosition = newPositionAndSize[0];
    this.position = Offset(
      newPosition,
      this.position.dy,
    );

    final double newSize = newPositionAndSize[1];
    this.size = Offset(
      newSize,
      this.size.dy,
    );

    return this;
  }

  double _magnetAxisAfterMove({
    @required double axisDelta,
    @required double axisScreenSize,
    @required List<Ray> nodeAxisRays,
    @required Function searchNearestOnDirectionGuidelineFromRays,
    @required Function getFoundGuideline,
    @required Function clearFoundGuideline,
    @required Function searchGuidelinesUnderRays,
  }) {
    final double nodeStartPosition = nodeAxisRays
        .firstWhere((Ray ray) =>
            ray.onObjectPositionType == OnObjectPositionTypes.start)
        .axisPosition;

    final double nodeCenterPosition = nodeAxisRays
        .firstWhere((Ray ray) =>
            ray.onObjectPositionType == OnObjectPositionTypes.center)
        .axisPosition;

    final double nodeEndPosition = nodeAxisRays
        .firstWhere(
            (Ray ray) => ray.onObjectPositionType == OnObjectPositionTypes.end)
        .axisPosition;

    final double nodeSize = nodeEndPosition - nodeStartPosition;

    if (axisDelta != 0) {
      searchNearestOnDirectionGuidelineFromRays(
          rays: nodeAxisRays,
          direction:
              axisDelta > 0 ? MoveDirections.forward : MoveDirections.backward);

      final FoundGuideline foundGuideline = getFoundGuideline();

      if (foundGuideline == null) return nodeStartPosition;

      double newStartPosition = nodeStartPosition;

      if (foundGuideline.foundByPositionType == OnObjectPositionTypes.start) {
        newStartPosition = foundGuideline.guideline.axisPosition;
      }

      if (foundGuideline.foundByPositionType == OnObjectPositionTypes.center) {
        newStartPosition = foundGuideline.guideline.axisPosition -
            (nodeCenterPosition - nodeStartPosition);
      }

      if (foundGuideline.foundByPositionType == OnObjectPositionTypes.end) {
        newStartPosition = foundGuideline.guideline.axisPosition -
            (nodeEndPosition - nodeStartPosition);
      }

      final isOverflowed =
          newStartPosition < 0 || newStartPosition + nodeSize > axisScreenSize;

      if (isOverflowed) {
        clearFoundGuideline();
        return nodeStartPosition;
      }

      return newStartPosition;
    }

    return nodeStartPosition;
  }

  SchemaNode magnetHorizontalMove({
    @required double deltaDx,
    @required double screenSizeDx,
    @required GuidelinesManager guidelinesManager,
  }) {
    final OrientationTypes raysOrientation = OrientationTypes.vertical;

    final List<Ray> startRays = Ray.getOrientedRays(
        startPosition: this.position.dx,
        objectSize: this.size.dx,
        raysOrientation: raysOrientation);

    guidelinesManager.searchGuidelinesUnderVerticalRays(rays: startRays);

    if (guidelinesManager.foundGuidelines.vertical != null &&
        deltaDx.abs() < SchemaNode.demagnetizeSideDelta) {
      return this;
    }

    this.position = Offset(
      this.axisMove(
          axisNodePosition: this.position.dx,
          axisNodeSize: this.size.dx,
          axisDelta: deltaDx,
          axisScreenSize: screenSizeDx),
      this.position.dy,
    );

    final List<Ray> movedRays = Ray.getOrientedRays(
        startPosition: this.position.dx,
        objectSize: this.size.dx,
        raysOrientation: raysOrientation);

    this.position = Offset(
      this._magnetAxisAfterMove(
        axisDelta: deltaDx,
        axisScreenSize: screenSizeDx,
        nodeAxisRays: movedRays,
        searchNearestOnDirectionGuidelineFromRays:
            guidelinesManager.searchNearestVerticalOnDirectionGuidelineFromRays,
        getFoundGuideline: () => guidelinesManager.foundGuidelines.vertical,
        clearFoundGuideline: guidelinesManager.clearVertical,
        searchGuidelinesUnderRays:
            guidelinesManager.searchGuidelinesUnderVerticalRays,
      ),
      this.position.dy,
    );

    final List<Ray> endRays = Ray.getOrientedRays(
        startPosition: this.position.dx,
        objectSize: this.size.dx,
        raysOrientation: raysOrientation);

    guidelinesManager.searchGuidelinesUnderVerticalRays(rays: endRays);

    return this;
  }

  SchemaNode magnetVerticalMove({
    @required double deltaDy,
    @required double screenSizeDy,
    @required GuidelinesManager guidelinesManager,
  }) {
    final OrientationTypes raysOrientation = OrientationTypes.horizontal;

    final List<Ray> startRays = Ray.getOrientedRays(
        startPosition: this.position.dy,
        objectSize: this.size.dy,
        raysOrientation: raysOrientation);

    guidelinesManager.searchGuidelinesUnderHorizontalRays(rays: startRays);

    if (guidelinesManager.foundGuidelines.horizontal != null &&
        deltaDy.abs() < SchemaNode.demagnetizeSideDelta) {
      return this;
    }

    this.position = Offset(
      this.position.dx,
      this.axisMove(
          axisNodePosition: this.position.dy,
          axisNodeSize: this.size.dy,
          axisDelta: deltaDy,
          axisScreenSize: screenSizeDy),
    );

    final List<Ray> movedRays = Ray.getOrientedRays(
        startPosition: this.position.dy,
        objectSize: this.size.dy,
        raysOrientation: raysOrientation);

    this.position = Offset(
      this.position.dx,
      this._magnetAxisAfterMove(
        axisDelta: deltaDy,
        axisScreenSize: screenSizeDy,
        nodeAxisRays: movedRays,
        searchNearestOnDirectionGuidelineFromRays: guidelinesManager
            .searchNearestHorizontalOnDirectionGuidelineFromRays,
        getFoundGuideline: () => guidelinesManager.foundGuidelines.horizontal,
        clearFoundGuideline: guidelinesManager.clearHorizontal,
        searchGuidelinesUnderRays:
            guidelinesManager.searchGuidelinesUnderHorizontalRays,
      ),
    );

    return this;
  }

  List<double> _magnetResizeSizeWithAnchorPoint({
    @required double position,
    @required double size,
    @required FoundGuideline foundGuideline,
    @required double axisScreenSize,
    @required Function clearGuideline,
  }) {
    double magnetizedNodePosition = position;
    double magnetizedNodeSize = size;

    double resizeDelta = 0;

    if (foundGuideline.foundByPositionType == OnObjectPositionTypes.start) {
      resizeDelta = position - foundGuideline.guideline.axisPosition;
    }

    if (foundGuideline.foundByPositionType == OnObjectPositionTypes.center) {
      final double centerPosition =
          magnetizedNodePosition + magnetizedNodeSize / 2;
      resizeDelta =
          (centerPosition - foundGuideline.guideline.axisPosition) * 2;
    }

    magnetizedNodePosition -= resizeDelta;
    magnetizedNodeSize += resizeDelta;

    final isOverflowed = magnetizedNodePosition < 0 ||
        magnetizedNodePosition + magnetizedNodeSize > axisScreenSize;

    if (magnetizedNodeSize < SchemaNode.minimalSize || isOverflowed) {
      clearGuideline();
      return [position, size];
    }

    return [magnetizedNodePosition, magnetizedNodeSize];
  }

  double _magnetResize({
    @required double position,
    @required double size,
    @required FoundGuideline foundGuideline,
    @required double axisScreenSize,
    @required Function clearGuideline,
  }) {
    double magnetizedNodeSize = size;

    double resizeDelta = 0;

    if (foundGuideline.foundByPositionType == OnObjectPositionTypes.end) {
      resizeDelta = foundGuideline.guideline.axisPosition - (position + size);
    }

    if (foundGuideline.foundByPositionType == OnObjectPositionTypes.center) {
      final double centerPosition = position + size / 2;
      resizeDelta =
          (foundGuideline.guideline.axisPosition - centerPosition) * 2;
    }

    magnetizedNodeSize += resizeDelta;

    final isOverflowed = position + magnetizedNodeSize > axisScreenSize;

    if (magnetizedNodeSize < SchemaNode.minimalSize || isOverflowed) {
      clearGuideline();
      return size;
    }

    return magnetizedNodeSize;
  }

  SchemaNode magnetTopResize({
    @required double deltaDy,
    @required double screenSizeDy,
    @required GuidelinesManager guidelinesManager,
  }) {
    final OrientationTypes raysOrientation = OrientationTypes.horizontal;

    final List<Ray> startRays = Ray.getOrientedRays(
      startPosition: this.position.dy,
      objectSize: this.size.dy,
      raysOrientation: raysOrientation,
    )
        .where(
            (Ray ray) => ray.onObjectPositionType != OnObjectPositionTypes.end)
        .toList();

    guidelinesManager.searchGuidelinesUnderHorizontalRays(rays: startRays);

    if (!SchemaNode.canDemagnetize(
        foundGuideline: guidelinesManager.foundGuidelines.horizontal,
        delta: deltaDy)) {
      return this;
    }

    this.resizeTop(deltaDy: deltaDy, screenSizeDy: screenSizeDy);

    if (deltaDy != 0) {
      final List<Ray> movedRays = Ray.getOrientedRays(
        startPosition: this.position.dy,
        objectSize: this.size.dy,
        raysOrientation: raysOrientation,
      )
          .where((Ray ray) =>
              ray.onObjectPositionType != OnObjectPositionTypes.end)
          .toList();

      guidelinesManager.searchNearestHorizontalOnDirectionGuidelineFromRays(
          rays: movedRays,
          direction:
              deltaDy > 0 ? MoveDirections.forward : MoveDirections.backward);

      final FoundGuideline foundGuideline =
          guidelinesManager.foundGuidelines.horizontal;

      if (foundGuideline == null) return this;

      final List<double> magnetizedNodePositionAndSize =
          this._magnetResizeSizeWithAnchorPoint(
        position: this.position.dy,
        size: this.size.dy,
        foundGuideline: foundGuideline,
        axisScreenSize: screenSizeDy,
        clearGuideline: guidelinesManager.clearHorizontal,
      );

      final double newPositionDy = magnetizedNodePositionAndSize[0];
      final double newSizeDy = magnetizedNodePositionAndSize[1];

      this.position = Offset(
        this.position.dx,
        newPositionDy,
      );

      this.size = Offset(
        this.size.dx,
        newSizeDy,
      );

      final List<Ray> endRays = Ray.getOrientedRays(
        startPosition: this.position.dy,
        objectSize: this.size.dy,
        raysOrientation: raysOrientation,
      )
          .where((Ray ray) =>
              ray.onObjectPositionType != OnObjectPositionTypes.end)
          .toList();

      guidelinesManager.searchGuidelinesUnderHorizontalRays(rays: endRays);

      return this;
    }

    return this;
  }

  SchemaNode magnetRightResize({
    @required double deltaDx,
    @required double screenSizeDx,
    @required GuidelinesManager guidelinesManager,
  }) {
    final OrientationTypes raysOrientation = OrientationTypes.vertical;

    final List<Ray> startRays = Ray.getOrientedRays(
      startPosition: this.position.dx,
      objectSize: this.size.dx,
      raysOrientation: raysOrientation,
    )
        .where((Ray ray) =>
            ray.onObjectPositionType != OnObjectPositionTypes.start)
        .toList();

    guidelinesManager.searchGuidelinesUnderVerticalRays(rays: startRays);

    if (!SchemaNode.canDemagnetize(
        foundGuideline: guidelinesManager.foundGuidelines.vertical,
        delta: deltaDx)) {
      return this;
    }

    this.resizeRight(deltaDx: deltaDx, screenSizeDx: screenSizeDx);

    if (deltaDx != 0) {
      final List<Ray> movedRays = Ray.getOrientedRays(
        startPosition: this.position.dx,
        objectSize: this.size.dx,
        raysOrientation: raysOrientation,
      )
          .where((Ray ray) =>
              ray.onObjectPositionType != OnObjectPositionTypes.start)
          .toList();

      guidelinesManager.searchNearestVerticalOnDirectionGuidelineFromRays(
          rays: movedRays,
          direction:
              deltaDx > 0 ? MoveDirections.forward : MoveDirections.backward);

      final FoundGuideline foundGuideline =
          guidelinesManager.foundGuidelines.vertical;

      if (foundGuideline == null) return this;

      final double newSizeDx = this._magnetResize(
        position: this.position.dx,
        size: this.size.dx,
        foundGuideline: foundGuideline,
        axisScreenSize: screenSizeDx,
        clearGuideline: guidelinesManager.clearVertical,
      );

      this.size = Offset(
        newSizeDx,
        this.size.dy,
      );

      final List<Ray> endRays = Ray.getOrientedRays(
        startPosition: this.position.dx,
        objectSize: this.size.dx,
        raysOrientation: raysOrientation,
      )
          .where((Ray ray) =>
              ray.onObjectPositionType != OnObjectPositionTypes.start)
          .toList();

      guidelinesManager.searchGuidelinesUnderVerticalRays(rays: endRays);

      return this;
    }

    return this;
  }

  SchemaNode magnetBottomResize({
    @required double deltaDy,
    @required double screenSizeDy,
    @required GuidelinesManager guidelinesManager,
  }) {
    final OrientationTypes raysOrientation = OrientationTypes.horizontal;

    final List<Ray> startRays = Ray.getOrientedRays(
      startPosition: this.position.dy,
      objectSize: this.size.dy,
      raysOrientation: raysOrientation,
    )
        .where((Ray ray) =>
            ray.onObjectPositionType != OnObjectPositionTypes.start)
        .toList();

    guidelinesManager.searchGuidelinesUnderHorizontalRays(rays: startRays);

    if (!SchemaNode.canDemagnetize(
        foundGuideline: guidelinesManager.foundGuidelines.horizontal,
        delta: deltaDy)) {
      return this;
    }

    this.resizeBottom(deltaDy: deltaDy, screenSizeDy: screenSizeDy);

    if (deltaDy != 0) {
      final List<Ray> movedRays = Ray.getOrientedRays(
        startPosition: this.position.dy,
        objectSize: this.size.dy,
        raysOrientation: raysOrientation,
      )
          .where((Ray ray) =>
              ray.onObjectPositionType != OnObjectPositionTypes.start)
          .toList();

      guidelinesManager.searchNearestHorizontalOnDirectionGuidelineFromRays(
          rays: movedRays,
          direction:
              deltaDy > 0 ? MoveDirections.forward : MoveDirections.backward);

      final FoundGuideline foundGuideline =
          guidelinesManager.foundGuidelines.horizontal;

      if (foundGuideline == null) return this;

      final double newSizeDy = this._magnetResize(
        position: this.position.dy,
        size: this.size.dy,
        foundGuideline: foundGuideline,
        axisScreenSize: screenSizeDy,
        clearGuideline: guidelinesManager.clearHorizontal,
      );

      this.size = Offset(
        this.size.dx,
        newSizeDy,
      );

      final List<Ray> endRays = Ray.getOrientedRays(
        startPosition: this.position.dy,
        objectSize: this.size.dy,
        raysOrientation: raysOrientation,
      )
          .where((Ray ray) =>
              ray.onObjectPositionType != OnObjectPositionTypes.start)
          .toList();

      guidelinesManager.searchGuidelinesUnderHorizontalRays(rays: endRays);

      return this;
    }

    return this;
  }

  SchemaNode magnetLeftResize({
    @required double deltaDx,
    @required double screenSizeDx,
    @required GuidelinesManager guidelinesManager,
  }) {
    final OrientationTypes raysOrientation = OrientationTypes.vertical;

    final List<Ray> startRays = Ray.getOrientedRays(
      startPosition: this.position.dx,
      objectSize: this.size.dx,
      raysOrientation: raysOrientation,
    )
        .where(
            (Ray ray) => ray.onObjectPositionType != OnObjectPositionTypes.end)
        .toList();

    guidelinesManager.searchGuidelinesUnderVerticalRays(rays: startRays);

    if (!SchemaNode.canDemagnetize(
        foundGuideline: guidelinesManager.foundGuidelines.vertical,
        delta: deltaDx)) {
      return this;
    }

    this.resizeLeft(deltaDx: deltaDx, screenSizeDx: screenSizeDx);

    if (deltaDx != 0) {
      final List<Ray> movedRays = Ray.getOrientedRays(
        startPosition: this.position.dx,
        objectSize: this.size.dx,
        raysOrientation: raysOrientation,
      )
          .where((Ray ray) =>
              ray.onObjectPositionType != OnObjectPositionTypes.end)
          .toList();

      guidelinesManager.searchNearestVerticalOnDirectionGuidelineFromRays(
          rays: movedRays,
          direction:
              deltaDx > 0 ? MoveDirections.forward : MoveDirections.backward);

      final FoundGuideline foundGuideline =
          guidelinesManager.foundGuidelines.vertical;

      if (foundGuideline == null) return this;

      final List<double> magnetizedNodePositionAndSize = this._magnetResizeSizeWithAnchorPoint(
        position: this.position.dx,
        size: this.size.dx,
        foundGuideline: foundGuideline,
        axisScreenSize: screenSizeDx,
        clearGuideline: guidelinesManager.clearHorizontal,
      );

      final double newPositionDx = magnetizedNodePositionAndSize[0];
      final double newSizeDx = magnetizedNodePositionAndSize[1];

      this.position = Offset(
        newPositionDx,
        this.position.dy,
      );

      this.size = Offset(
        newSizeDx,
        this.size.dy,
      );

      final List<Ray> endRays = Ray.getOrientedRays(
        startPosition: this.position.dx,
        objectSize: this.size.dx,
        raysOrientation: raysOrientation,
      )
          .where((Ray ray) =>
              ray.onObjectPositionType != OnObjectPositionTypes.end)
          .toList();

      guidelinesManager.searchGuidelinesUnderVerticalRays(rays: endRays);

      return this;
    }

    return this;
  }

  Map<String, dynamic> toJson() => {
        'position': {'x': position.dx, 'y': position.dy},
        'size': {'x': size.dx, 'y': size.dy},
        'properties': _jsonProperties(),
        'actions': _jsonActions(),
        'type': this.type.toString()
      };

  Widget toWidget({bool isPlayMode});

  Widget toEditProps(
    Function wrapInRootProps,
    Function(SchemaNodeProperty, [bool, dynamic]) changePropertyTo,
  );

  Map<String, dynamic> _jsonActions() {
    final Map<String, dynamic> map = {};
    print(actions.values.map((v) => v.toJson()));
    actions.forEach((k, v) => map[k] = v.toJson());
    return map;
  }

  Map<String, dynamic> _jsonProperties() {
    final Map<String, dynamic> map = {};
    properties.forEach((k, v) => map[k] = v.toJson());
    return map;
  }
}
