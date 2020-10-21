import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/AppThemeStore.dart';
import 'dart:core';

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
  AppThemeStore themeStore;
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

  static List<double> resizeAxisWithAnchorPoint({
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

  static double resizeAxis({
    @required double position,
    @required double size,
    @required double delta,
    @required double axisScreenSize,
  }) {
    double newSize = size + delta;

    if (newSize < SchemaNode.minimalSize) {
      newSize = SchemaNode.minimalSize;
    }

    if (position + size > axisScreenSize) {
      newSize = axisScreenSize - position;
    }

    return newSize;
  }

  static SchemaNode resizeTop({
    @required SchemaNode node,
    @required double delta,
    @required double screenSize,
  }) {

    List<double> newPositionAndSize = resizeAxisWithAnchorPoint(
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
    final newSize = resizeAxis(
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
    final newSize = resizeAxis(
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
    List<double> newPositionAndSize = resizeAxisWithAnchorPoint(
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

  Map<String, dynamic> toJson() => {
        'position': {'x': position.dx, 'y': position.dy},
        'size': {'x': size.dx, 'y': size.dy},
        'properties': _jsonProperties(),
        'actions': _jsonActions(),
        'type': this.type.toString()
      };
  Widget toWidget({bool isPlayMode, UserActions userActions});
  Widget toEditProps(
    UserActions userActions,
  );

  Map<String, dynamic> _jsonActions() {
    final Map<String, dynamic> map = {};
    actions.forEach((k, v) => map[k] = v.toJson());
    return map;
  }

  Map<String, dynamic> _jsonProperties() {
    final Map<String, dynamic> map = {};
    properties.forEach((k, v) => map[k] = v.toJson());
    return map;
  }
}
