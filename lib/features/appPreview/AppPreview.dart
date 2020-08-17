import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/widgetTransformaions/WidgetPositionAfterDropOnPreview.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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

  double constrainPosition(double value, double maxValue) {
    if (value <= 0) return 0.0;
    if (value >= maxValue) return maxValue;
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<SchemaNode>(
      onAcceptWithDetails: (details) {
        final newPosition =
            WidgetPositionAfterDropOnPreview(context, details).calculate();
        userActions.placeWidget(details.data, schemaStore, newPosition);
      },
      builder: (context, candidateData, rejectedData) {
        return GestureDetector(
            onTap: () {
              log('Canvas Tapped');
            },
            child: (Container(
              color: Colors.black12,
              width: 375,
              height: 750,
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
                              onPanUpdate: (details) {
                                node.position = Offset(
                                  constrainPosition(
                                      node.position.dx + details.delta.dx,
                                      375.0),
                                  constrainPosition(
                                      node.position.dy + details.delta.dy,
                                      750.0),
                                );
                                schemaStore.update(node);
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow:
                                        userActions.selectedNode() != null &&
                                                userActions.selectedNode().id ==
                                                    node.id
                                            ? [
                                                BoxShadow(
                                                    offset: Offset.zero,
                                                    blurRadius: 10,
                                                    color: Colors.blue)
                                              ]
                                            : [],
                                  ),
                                  child: node.toWidget())),
                          top: node.position.dy,
                          left: node.position.dx))
                    ],
                  );
                },
              ),
            )));
      },
    );
  }
}
