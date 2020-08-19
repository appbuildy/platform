import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/widgetTransformaions/WidgetPositionAfterDropOnPreview.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

const SCREEN_WIDTH = 375.0;
const SCREEN_HEIGHT = 750.0;

class AppPreview extends StatefulWidget {
  final SchemaStore schemaStore;
  final UserActions userActions;

  const AppPreview({Key key, @required this.schemaStore, this.userActions})
      : super(key: key);

  @override
  _AppPreviewState createState() => _AppPreviewState();
}

class _AppPreviewState extends State<AppPreview> {
  SchemaStore schemaStore;
  UserActions userActions;
  int counter;

  @override
  void initState() {
    super.initState();
    schemaStore = widget.schemaStore;
    userActions = widget.userActions;
  }

  double constrainPosition(double value, double sideSize, double maxValue) {
    if (value <= 0) return -1.0;
    if (value + sideSize >= maxValue) return maxValue - sideSize;

    return value;
  }

  double constrainPosition2({
    @required double size,
    @required double value,
    @required double position,
    @required double max,
  }) {
    if (value + position <= 0.0) {
      return 0.0;
    } else if (value + position + size >= max) {
      return max - size;
    }
    ;

    return value + position;
  }

  double constrainSize({
    @required double size,
    @required double value,
    @required double position,
    @required double max,
    bool isSub = false,
  }) {
    if (size + value + position >= max) {
      return (max - position).toInt().toDouble();
    }
    return isSub
        ? (size - value).toInt().toDouble()
        : (size + value).toInt().toDouble();
  }

  Widget renderWithSelected({SchemaNode node}) {
    final isSelected = userActions.selectedNode() != null &&
        userActions.selectedNode().id == node.id;

    final List<Widget> dots = isSelected
        ? [
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onPanUpdate: (details) {
                  node.position = Offset(
                    node.position.dx,
                    constrainPosition2(
                        position: node.position.dy,
                        value: details.delta.dy,
                        size: node.size.dy,
                        max: SCREEN_HEIGHT),
                  );
                  node.size = Offset(
                      constrainSize(
                        size: node.size.dx,
                        position: node.position.dx,
                        max: SCREEN_WIDTH,
                        value: details.delta.dx,
                      ),
                      constrainSize(
                        size: node.size.dy,
                        position: node.position.dy,
                        max: SCREEN_HEIGHT,
                        value: details.delta.dy,
                        isSub: true,
                      ));
                  schemaStore.update(node);
                },
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: GestureDetector(
                onPanUpdate: (details) {
                  node.position = Offset(
                    constrainPosition2(
                        position: node.position.dx,
                        value: details.delta.dx,
                        size: node.size.dx,
                        max: SCREEN_WIDTH),
                    constrainPosition2(
                        position: node.position.dy,
                        value: details.delta.dy,
                        size: node.size.dy,
                        max: SCREEN_HEIGHT),
                  );
                  node.size = Offset(
                      constrainSize(
                        size: node.size.dx,
                        position: node.position.dx,
                        max: SCREEN_WIDTH,
                        value: details.delta.dx,
                        isSub: true,
                      ),
                      constrainSize(
                        size: node.size.dy,
                        position: node.position.dy,
                        max: SCREEN_HEIGHT,
                        value: details.delta.dy,
                        isSub: true,
                      ));
                  schemaStore.update(node);
                },
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: GestureDetector(
                onPanUpdate: (details) {
                  node.position = Offset(
                    constrainPosition2(
                        position: node.position.dx,
                        value: details.delta.dx,
                        size: node.size.dx,
                        max: SCREEN_WIDTH),
                    node.position.dy,
                  );
                  node.size = Offset(
                      constrainSize(
                        size: node.size.dx,
                        position: node.position.dx,
                        max: SCREEN_WIDTH,
                        value: details.delta.dx,
                        isSub: true,
                      ),
                      constrainSize(
                        size: node.size.dy,
                        position: node.position.dy,
                        max: SCREEN_HEIGHT,
                        value: details.delta.dy,
                      ));
                  schemaStore.update(node);
                },
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onPanUpdate: (details) {
                  node.position = Offset(
                    node.position.dx,
                    node.position.dy,
                  );
                  node.size = Offset(
                      constrainSize(
                        size: node.size.dx,
                        position: node.position.dx,
                        max: SCREEN_WIDTH,
                        value: details.delta.dx,
                      ),
                      constrainSize(
                        size: node.size.dy,
                        position: node.position.dy,
                        max: SCREEN_HEIGHT,
                        value: details.delta.dy,
                      ));
                  schemaStore.update(node);
                },
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ]
        : [Container()];

    return Container(
      width: node.size.dx,
      height: node.size.dy,
      child: Stack(
        alignment: Alignment.center,
        children: [
          isSelected
              ? Container(
                  width: node.size.dx,
                  height: node.size.dy,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.red)),
                )
              : Container(
                  width: node.size.dx,
                  height: node.size.dy,
                ),
          GestureDetector(
            onPanUpdate: (details) {
              node.position = Offset(
                constrainPosition2(
                    position: node.position.dx,
                    value: details.delta.dx,
                    size: node.size.dx,
                    max: SCREEN_WIDTH),
                constrainPosition2(
                    position: node.position.dy,
                    value: details.delta.dy,
                    size: node.size.dy,
                    max: SCREEN_HEIGHT),
              );
              schemaStore.update(node);
            },
            child: Container(
              width: isSelected ? node.size.dx - 2 : node.size.dx,
              height: isSelected ? node.size.dy - 2 : node.size.dy,
              child: node.toWidget(),
            ),
          ),
          ...dots,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<SchemaNode>(
      onAcceptWithDetails: (details) {
        final newPosition =
            WidgetPositionAfterDropOnPreview(context, details).calculate();
        userActions.placeWidget(details.data, newPosition);
      },
      builder: (context, candidateData, rejectedData) {
        return (Container(
          color: Colors.black12,
          width: SCREEN_WIDTH,
          height: SCREEN_HEIGHT,
          child: Observer(
            builder: (context) {
              log('i rerendered');
              return Stack(
                textDirection: TextDirection.ltr,
                children: [
                  ...schemaStore.components.map((node) => Positioned(
                      child: GestureDetector(
                          onTapDown: (details) {
                            userActions.selectNodeForEdit(node);
                          },
                          child: renderWithSelected(
                            node: node,
                          )),
                      top: node.position.dy,
                      left: node.position.dx))
                ],
              );
            },
          ),
        ));
      },
    );
  }
}
