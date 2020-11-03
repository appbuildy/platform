import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/GuidelinesManager/GuidelinesManager.dart';
import 'package:flutter_app/features/schemaInteractions/GuidelinesManager/Rays.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeSpawner.dart';

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
  SchemaNodeSpawner parent;
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

  static double axisMove({
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

  static SchemaNode move({
    @required SchemaNode node,
    @required Offset delta,
    @required Offset screenSize,
  }) {
    node.position = Offset(
      SchemaNode.axisMove(
        axisNodePosition: node.position.dx,
        axisNodeSize: node.size.dx,
        axisDelta: delta.dx,
        axisScreenSize: screenSize.dx,
      ),
      SchemaNode.axisMove(
        axisNodePosition: node.position.dy,
        axisNodeSize: node.size.dy,
        axisDelta: delta.dy,
        axisScreenSize: screenSize.dy,
      ),
    );

    return node;
  }

  static List<double> resizeSideWithAnchorPoint({
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

  static double resizeSide({
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

  static SchemaNode resizeTop({
    @required SchemaNode node,
    @required double delta,
    @required double screenSize,
  }) {
    List<double> newPositionAndSize = resizeSideWithAnchorPoint(
      position: node.position.dy,
      size: node.size.dy,
      delta: delta,
      axisScreenSize: screenSize,
    );

    final double newPosition = newPositionAndSize[0];
    node.position = Offset(
      node.position.dx,
      newPosition,
    );

    final double newSize = newPositionAndSize[1];
    node.size = Offset(
      node.size.dx,
      newSize,
    );

    return node;
  }

  static SchemaNode resizeRight({
    @required SchemaNode node,
    @required double delta,
    @required double screenSize,
  }) {
    final newSize = resizeSide(
      position: node.position.dx,
      size: node.size.dx,
      delta: delta,
      axisScreenSize: screenSize,
    );

    node.size = Offset(
      newSize,
      node.size.dy,
    );

    return node;
  }

  static SchemaNode resizeBottom({
    @required SchemaNode node,
    @required double delta,
    @required double screenSize,
  }) {
    final newSize = resizeSide(
      position: node.position.dy,
      size: node.size.dy,
      delta: delta,
      axisScreenSize: screenSize,
    );

    node.size = Offset(
      node.size.dx,
      newSize,
    );

    return node;
  }

  static SchemaNode resizeLeft({
    @required SchemaNode node,
    @required double delta,
    @required double screenSize,
  }) {
    List<double> newPositionAndSize = resizeSideWithAnchorPoint(
      position: node.position.dx,
      size: node.size.dx,
      delta: delta,
      axisScreenSize: screenSize,
    );

    final double newPosition = newPositionAndSize[0];
    node.position = Offset(
      newPosition,
      node.position.dy,
    );

    final double newSize = newPositionAndSize[1];
    node.size = Offset(
      newSize,
      node.size.dy,
    );

    return node;
  }

  static double magnetAxisAfterMove({
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

  static SchemaNode magnetHorizontalMove({
    @required SchemaNode node,
    @required double deltaDx,
    @required double screenSizeDx,
    @required GuidelinesManager guidelinesManager,
  }) {
    final OrientationTypes raysOrientation = OrientationTypes.vertical;

    final List<Ray> startRays = Ray.getOrientedRays(
        startPosition: node.position.dx,
        objectSize: node.size.dx,
        raysOrientation: raysOrientation);

    guidelinesManager.searchGuidelinesUnderVerticalRays(rays: startRays);

    if (guidelinesManager.foundGuidelines.vertical != null &&
        deltaDx.abs() < SchemaNode.demagnetizeSideDelta) {
      return node;
    }

    node.position = Offset(
      SchemaNode.axisMove(
          axisNodePosition: node.position.dx,
          axisNodeSize: node.size.dx,
          axisDelta: deltaDx,
          axisScreenSize: screenSizeDx),
      node.position.dy,
    );

    final List<Ray> movedRays = Ray.getOrientedRays(
        startPosition: node.position.dx,
        objectSize: node.size.dx,
        raysOrientation: raysOrientation);

    node.position = Offset(
      SchemaNode.magnetAxisAfterMove(
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
      node.position.dy,
    );

    final List<Ray> endRays = Ray.getOrientedRays(
        startPosition: node.position.dx,
        objectSize: node.size.dx,
        raysOrientation: raysOrientation);

    guidelinesManager.searchGuidelinesUnderVerticalRays(rays: endRays);

    return node;
  }

  static SchemaNode magnetVerticalMove({
    @required SchemaNode node,
    @required double deltaDy,
    @required double screenSizeDy,
    @required GuidelinesManager guidelinesManager,
  }) {
    final OrientationTypes raysOrientation = OrientationTypes.horizontal;

    final List<Ray> startRays = Ray.getOrientedRays(
        startPosition: node.position.dy,
        objectSize: node.size.dy,
        raysOrientation: raysOrientation);

    guidelinesManager.searchGuidelinesUnderHorizontalRays(rays: startRays);

    if (guidelinesManager.foundGuidelines.horizontal != null &&
        deltaDy.abs() < SchemaNode.demagnetizeSideDelta) {
      return node;
    }

    node.position = Offset(
      node.position.dx,
      SchemaNode.axisMove(
          axisNodePosition: node.position.dy,
          axisNodeSize: node.size.dy,
          axisDelta: deltaDy,
          axisScreenSize: screenSizeDy),
    );

    final List<Ray> movedRays = Ray.getOrientedRays(
        startPosition: node.position.dy,
        objectSize: node.size.dy,
        raysOrientation: raysOrientation);

    node.position = Offset(
      node.position.dx,
      SchemaNode.magnetAxisAfterMove(
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

    return node;
  }

  static List<double> magnetResizeSizeWithAnchorPoint({
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

  static double magnetResize({
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

  static SchemaNode magnetTopResize({
    @required SchemaNode node,
    @required double deltaDy,
    @required double screenSizeDy,
    @required GuidelinesManager guidelinesManager,
  }) {
    final OrientationTypes raysOrientation = OrientationTypes.horizontal;

    final List<Ray> startRays = Ray.getOrientedRays(
      startPosition: node.position.dy,
      objectSize: node.size.dy,
      raysOrientation: raysOrientation,
    )
        .where(
            (Ray ray) => ray.onObjectPositionType != OnObjectPositionTypes.end)
        .toList();

    guidelinesManager.searchGuidelinesUnderHorizontalRays(rays: startRays);

    if (!SchemaNode.canDemagnetize(
        foundGuideline: guidelinesManager.foundGuidelines.horizontal,
        delta: deltaDy)) {
      return node;
    }

    node = SchemaNode.resizeTop(
        node: node, delta: deltaDy, screenSize: screenSizeDy);

    if (deltaDy != 0) {
      final List<Ray> movedRays = Ray.getOrientedRays(
        startPosition: node.position.dy,
        objectSize: node.size.dy,
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

      if (foundGuideline == null) return node;

      final List<double> magnetizedNodePositionAndSize =
          SchemaNode.magnetResizeSizeWithAnchorPoint(
        position: node.position.dy,
        size: node.size.dy,
        foundGuideline: foundGuideline,
        axisScreenSize: screenSizeDy,
        clearGuideline: guidelinesManager.clearHorizontal,
      );

      final double newPositionDy = magnetizedNodePositionAndSize[0];
      final double newSizeDy = magnetizedNodePositionAndSize[1];

      node.position = Offset(
        node.position.dx,
        newPositionDy,
      );

      node.size = Offset(
        node.size.dx,
        newSizeDy,
      );

      final List<Ray> endRays = Ray.getOrientedRays(
        startPosition: node.position.dy,
        objectSize: node.size.dy,
        raysOrientation: raysOrientation,
      )
          .where((Ray ray) =>
              ray.onObjectPositionType != OnObjectPositionTypes.end)
          .toList();

      guidelinesManager.searchGuidelinesUnderHorizontalRays(rays: endRays);

      return node;
    }

    return node;
  }

  static SchemaNode magnetRightResize({
    @required SchemaNode node,
    @required double deltaDx,
    @required double screenSizeDx,
    @required GuidelinesManager guidelinesManager,
  }) {
    final OrientationTypes raysOrientation = OrientationTypes.vertical;

    final List<Ray> startRays = Ray.getOrientedRays(
      startPosition: node.position.dx,
      objectSize: node.size.dx,
      raysOrientation: raysOrientation,
    )
        .where((Ray ray) =>
            ray.onObjectPositionType != OnObjectPositionTypes.start)
        .toList();

    guidelinesManager.searchGuidelinesUnderVerticalRays(rays: startRays);

    if (!SchemaNode.canDemagnetize(
        foundGuideline: guidelinesManager.foundGuidelines.vertical,
        delta: deltaDx)) {
      return node;
    }

    node = SchemaNode.resizeRight(
        node: node, delta: deltaDx, screenSize: screenSizeDx);

    if (deltaDx != 0) {
      final List<Ray> movedRays = Ray.getOrientedRays(
        startPosition: node.position.dx,
        objectSize: node.size.dx,
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

      if (foundGuideline == null) return node;

      final double newSizeDx = SchemaNode.magnetResize(
        position: node.position.dx,
        size: node.size.dx,
        foundGuideline: foundGuideline,
        axisScreenSize: screenSizeDx,
        clearGuideline: guidelinesManager.clearVertical,
      );

      node.size = Offset(
        newSizeDx,
        node.size.dy,
      );

      final List<Ray> endRays = Ray.getOrientedRays(
        startPosition: node.position.dx,
        objectSize: node.size.dx,
        raysOrientation: raysOrientation,
      )
          .where((Ray ray) =>
              ray.onObjectPositionType != OnObjectPositionTypes.start)
          .toList();

      guidelinesManager.searchGuidelinesUnderVerticalRays(rays: endRays);

      return node;
    }

    return node;
  }

  static SchemaNode magnetBottomResize({
    @required SchemaNode node,
    @required double deltaDy,
    @required double screenSizeDy,
    @required GuidelinesManager guidelinesManager,
  }) {
    final OrientationTypes raysOrientation = OrientationTypes.horizontal;

    final List<Ray> startRays = Ray.getOrientedRays(
      startPosition: node.position.dy,
      objectSize: node.size.dy,
      raysOrientation: raysOrientation,
    )
        .where((Ray ray) =>
            ray.onObjectPositionType != OnObjectPositionTypes.start)
        .toList();

    guidelinesManager.searchGuidelinesUnderHorizontalRays(rays: startRays);

    if (!SchemaNode.canDemagnetize(
        foundGuideline: guidelinesManager.foundGuidelines.horizontal,
        delta: deltaDy)) {
      return node;
    }

    node = SchemaNode.resizeBottom(
        node: node, delta: deltaDy, screenSize: screenSizeDy);

    if (deltaDy != 0) {
      final List<Ray> movedRays = Ray.getOrientedRays(
        startPosition: node.position.dy,
        objectSize: node.size.dy,
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

      if (foundGuideline == null) return node;

      final double newSizeDy = SchemaNode.magnetResize(
        position: node.position.dy,
        size: node.size.dy,
        foundGuideline: foundGuideline,
        axisScreenSize: screenSizeDy,
        clearGuideline: guidelinesManager.clearHorizontal,
      );

      node.size = Offset(
        node.size.dx,
        newSizeDy,
      );

      final List<Ray> endRays = Ray.getOrientedRays(
        startPosition: node.position.dy,
        objectSize: node.size.dy,
        raysOrientation: raysOrientation,
      )
          .where((Ray ray) =>
              ray.onObjectPositionType != OnObjectPositionTypes.start)
          .toList();

      guidelinesManager.searchGuidelinesUnderHorizontalRays(rays: endRays);

      return node;
    }

    return node;
  }

  static SchemaNode magnetLeftResize({
    @required SchemaNode node,
    @required double deltaDx,
    @required double screenSizeDx,
    @required GuidelinesManager guidelinesManager,
  }) {
    final OrientationTypes raysOrientation = OrientationTypes.vertical;

    final List<Ray> startRays = Ray.getOrientedRays(
      startPosition: node.position.dx,
      objectSize: node.size.dx,
      raysOrientation: raysOrientation,
    )
        .where(
            (Ray ray) => ray.onObjectPositionType != OnObjectPositionTypes.end)
        .toList();

    guidelinesManager.searchGuidelinesUnderVerticalRays(rays: startRays);

    if (!SchemaNode.canDemagnetize(
        foundGuideline: guidelinesManager.foundGuidelines.vertical,
        delta: deltaDx)) {
      return node;
    }

    node = SchemaNode.resizeLeft(
        node: node, delta: deltaDx, screenSize: screenSizeDx);

    if (deltaDx != 0) {
      final List<Ray> movedRays = Ray.getOrientedRays(
        startPosition: node.position.dx,
        objectSize: node.size.dx,
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

      if (foundGuideline == null) return node;

      final List<double> magnetizedNodePositionAndSize =
          SchemaNode.magnetResizeSizeWithAnchorPoint(
        position: node.position.dx,
        size: node.size.dx,
        foundGuideline: foundGuideline,
        axisScreenSize: screenSizeDx,
        clearGuideline: guidelinesManager.clearHorizontal,
      );

      final double newPositionDx = magnetizedNodePositionAndSize[0];
      final double newSizeDx = magnetizedNodePositionAndSize[1];

      node.position = Offset(
        newPositionDx,
        node.position.dy,
      );

      node.size = Offset(
        newSizeDx,
        node.size.dy,
      );

      final List<Ray> endRays = Ray.getOrientedRays(
        startPosition: node.position.dx,
        objectSize: node.size.dx,
        raysOrientation: raysOrientation,
      )
          .where((Ray ray) =>
              ray.onObjectPositionType != OnObjectPositionTypes.end)
          .toList();

      guidelinesManager.searchGuidelinesUnderVerticalRays(rays: endRays);

      return node;
    }

    return node;
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
    Function(SchemaNodeProperty) onPropertyChange,
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
