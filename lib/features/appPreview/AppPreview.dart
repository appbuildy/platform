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
                    constrainPosition(
                        node.position.dy + details.delta.dy, 750.0),
                  );
                  node.size = Offset(node.size.dx + details.delta.dx,
                      node.size.dy - details.delta.dy);
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
                    constrainPosition(
                        node.position.dx + details.delta.dx, 375.0),
                    constrainPosition(
                        node.position.dy + details.delta.dy, 750.0),
                  );
                  node.size = Offset(node.size.dx - details.delta.dx,
                      node.size.dy - details.delta.dy);
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
                    constrainPosition(
                        node.position.dx + details.delta.dx, 375.0),
                    node.position.dy,
                  );
                  node.size = Offset(node.size.dx - details.delta.dx,
                      node.size.dy + details.delta.dy);
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
                  node.size = Offset(node.size.dx + details.delta.dx,
                      node.size.dy + details.delta.dy);
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
      width: node.size.dx + 8,
      height: node.size.dy + 8,
      child: Stack(
        alignment: Alignment.center,
        children: [
          isSelected
              ? Container(
                  width: node.size.dx + 4,
                  height: node.size.dy + 4,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.red)),
                )
              : Container(
                  width: node.size.dx + 6,
                  height: node.size.dy + 6,
                ),
          GestureDetector(
            onPanUpdate: (details) {
              node.position = Offset(
                constrainPosition(node.position.dx + details.delta.dx, 375.0),
                constrainPosition(node.position.dy + details.delta.dy, 750.0),
              );
              schemaStore.update(node);
            },
            child: Container(
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
