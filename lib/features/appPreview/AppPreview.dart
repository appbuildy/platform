import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/widgetTransformaions/WidgetPositionAfterDropOnPreview.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

enum SideEnum { topLeft, topRight, bottomRight, bottomLeft }

const SCREEN_WIDTH = 375.0;
const SCREEN_HEIGHT = 750.0;

class AppPreview extends StatefulWidget {
  final UserActions userActions;

  const AppPreview({Key key, this.userActions}) : super(key: key);

  @override
  _AppPreviewState createState() => _AppPreviewState();
}

class _AppPreviewState extends State<AppPreview> {
  UserActions userActions;
  int counter;

  @override
  void initState() {
    super.initState();
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
    bool isDisableWhenMin = false,
  }) {
    final int sizeInt = size.round();
    final int valueInt = value.round();
    final int positionInt = position.round();
    final int maxInt = max.round();

    if (isDisableWhenMin && sizeInt <= 80.0) {
      return positionInt.toDouble();
    }

    if (valueInt + positionInt <= 0) {
      return 0;
    } else if (valueInt + positionInt + sizeInt > maxInt) {
      return (maxInt - sizeInt).toDouble();
    }

    return valueInt + positionInt.toDouble();
  }

  double constrainSize({
    @required double size,
    @required double value,
    @required double position,
    @required double max,
    bool isSub = false,
  }) {
    final int sizeInt = size.round();
    final int valueInt = isSub ? value.round() * -1 : value.round();
    final int positionInt = position.round();
    final int maxInt = max.round();

//    if (isSub && positionInt <= 0) {
//      if (valueInt < 0) {
//        return (sizeInt + valueInt).toDouble();
//      }
//
//      return sizeInt.toDouble(); прыжок происходит потому что position уже поменялся и равен 0, а для сайза в таком случае value не прикладывается
//    }

    if (sizeInt + valueInt + positionInt > maxInt) {
      return (maxInt - positionInt).toDouble();
    } else if (sizeInt + valueInt < 80) {
      return 80.0;
    }
    return (sizeInt + valueInt).toDouble();
  }

  SchemaNode handleSizeChange(
      {@required SchemaNode node, Offset delta, SideEnum side}) {
    if (side == SideEnum.topLeft) {
      node.position = Offset(
        constrainPosition2(
            position: node.position.dx,
            value: delta.dx,
            size: node.size.dx,
            max: SCREEN_WIDTH,
            isDisableWhenMin: true),
        constrainPosition2(
            position: node.position.dy,
            value: delta.dy,
            size: node.size.dy,
            max: SCREEN_HEIGHT,
            isDisableWhenMin: true),
      );

      node.size = Offset(
          constrainSize(
            size: node.size.dx,
            position: node.position.dx,
            max: SCREEN_WIDTH,
            value: delta.dx,
            isSub: true,
          ),
          constrainSize(
            size: node.size.dy,
            position: node.position.dy,
            max: SCREEN_HEIGHT,
            value: delta.dy,
            isSub: true,
          ));
    } else if (side == SideEnum.topRight) {
      node.position = Offset(
        node.position.dx,
        constrainPosition2(
            position: node.position.dy,
            value: delta.dy,
            size: node.size.dy,
            max: SCREEN_HEIGHT,
            isDisableWhenMin: true),
      );
      node.size = Offset(
          constrainSize(
            size: node.size.dx,
            position: node.position.dx,
            max: SCREEN_WIDTH,
            value: delta.dx,
          ),
          constrainSize(
            size: node.size.dy,
            position: node.position.dy,
            max: SCREEN_HEIGHT,
            value: delta.dy,
            isSub: true,
          ));
    } else if (side == SideEnum.bottomLeft) {
      node.position = Offset(
        constrainPosition2(
          position: node.position.dx,
          value: delta.dx,
          size: node.size.dx,
          max: SCREEN_WIDTH,
          isDisableWhenMin: true,
        ),
        node.position.dy,
      );

      node.size = Offset(
          constrainSize(
            size: node.size.dx,
            position: node.position.dx,
            max: SCREEN_WIDTH,
            value: delta.dx,
            isSub: true,
          ),
          constrainSize(
            size: node.size.dy,
            position: node.position.dy,
            max: SCREEN_HEIGHT,
            value: delta.dy,
          ));
    } else if (side == SideEnum.bottomRight) {
      node.position = Offset(
        node.position.dx,
        node.position.dy,
      );
      node.size = Offset(
          constrainSize(
            size: node.size.dx,
            position: node.position.dx,
            max: SCREEN_WIDTH,
            value: delta.dx,
          ),
          constrainSize(
            size: node.size.dy,
            position: node.position.dy,
            max: SCREEN_HEIGHT,
            value: delta.dy,
          ));
    }

    return node;
  }

  Widget renderWithSelected({SchemaNode node}) {
    final isSelected = userActions.selectedNode() != null &&
        userActions.selectedNode().id == node.id;

    final Widget redCircle = Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red,
      ),
    );

    final List<Widget> dots = isSelected
        ? [
            Positioned(
              top: 0,
              left: 0,
              child: GestureDetector(
                onPanUpdate: (details) {
                  final updatedNode = handleSizeChange(
                      node: node, delta: details.delta, side: SideEnum.topLeft);
                  userActions.screens.current.update(updatedNode);
                },
                child: Cursor(cursor: CursorEnum.nwseResize, child: redCircle),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onPanUpdate: (details) {
                  final updatedNode = handleSizeChange(
                      node: node,
                      delta: details.delta,
                      side: SideEnum.topRight);
                  userActions.screens.current.update(updatedNode);
                },
                child: Cursor(cursor: CursorEnum.neswResize, child: redCircle),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onPanUpdate: (details) {
                  final updatedNode = handleSizeChange(
                      node: node,
                      delta: details.delta,
                      side: SideEnum.bottomRight);
                  userActions.screens.current.update(updatedNode);
                },
                child: Cursor(cursor: CursorEnum.nwseResize, child: redCircle),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: GestureDetector(
                onPanUpdate: (details) {
                  final updatedNode = handleSizeChange(
                      node: node,
                      delta: details.delta,
                      side: SideEnum.bottomLeft);
                  userActions.screens.current.update(updatedNode);
                },
                child: Cursor(cursor: CursorEnum.neswResize, child: redCircle),
              ),
            ),
          ]
        : [Container()];

    final lines = isSelected
        ? [
            Positioned(
              top: 0,
              left: 0,
              child: GestureDetector(
                onPanUpdate: (details) {
                  node.position = Offset(
                    node.position.dx,
                    constrainPosition2(
                        position: node.position.dy,
                        value: details.delta.dy,
                        size: node.size.dy,
                        max: SCREEN_HEIGHT,
                        isDisableWhenMin: true),
                  );

                  node.size = Offset(
                      node.size.dx,
                      constrainSize(
                        size: node.size.dy,
                        position: node.position.dy,
                        max: SCREEN_HEIGHT,
                        value: details.delta.dy,
                        isSub: true,
                      ));
                  userActions.screens.current.update(node);
                },
                child: Cursor(
                  cursor: CursorEnum.nsResize,
                  child: Container(
                    width: node.size.dx,
                    height: 10,
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(width: 1, color: Colors.red))),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
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
                    node.size.dy,
                  );
                  userActions.screens.current.update(node);
                },
                child: Cursor(
                  cursor: CursorEnum.ewResize,
                  child: Container(
                      width: 10,
                      height: node.size.dy,
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(width: 1, color: Colors.red)))),
                ),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: GestureDetector(
                onPanUpdate: (details) {
                  node.position = Offset(
                    node.position.dx,
                    node.position.dy,
                  );
                  node.size = Offset(
                      node.size.dx,
                      constrainSize(
                        size: node.size.dy,
                        position: node.position.dy,
                        max: SCREEN_HEIGHT,
                        value: details.delta.dy,
                      ));
                  userActions.screens.current.update(node);
                },
                child: Cursor(
                  cursor: CursorEnum.nsResize,
                  child: Container(
                      width: node.size.dx,
                      height: 10,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 1, color: Colors.red)))),
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
                          max: SCREEN_WIDTH,
                          isDisableWhenMin: true),
                      node.position.dy);

                  node.size = Offset(
                      constrainSize(
                        size: node.size.dx,
                        position: node.position.dx,
                        max: SCREEN_WIDTH,
                        value: details.delta.dx,
                        isSub: true,
                      ),
                      node.size.dy);
                  userActions.screens.current.update(node);
                },
                child: Cursor(
                  cursor: CursorEnum.ewResize,
                  child: Container(
                      width: 10,
                      height: node.size.dy,
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(width: 1, color: Colors.red)))),
                ),
              ),
            ),
          ]
        : [Container()];

    return Stack(
      alignment: Alignment.center,
      children: [
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
            userActions.screens.current.update(node);
          },
          child: Cursor(
            cursor: CursorEnum.move,
            child: Container(
              width: isSelected ? node.size.dx - 2 : node.size.dx,
              height: isSelected ? node.size.dy - 2 : node.size.dy,
              child: node.toWidget(),
            ),
          ),
        ),
        ...lines,
        ...dots,
      ],
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
              return Stack(
                textDirection: TextDirection.ltr,
                children: [
                  ...userActions.screens.current.components
                      .map((node) => Positioned(
                          child: GestureDetector(
                              onTapDown: (details) {
                                userActions.selectNodeForEdit(node);
                              },
                              child: renderWithSelected(
                                node: node,
                              )),
                          top: node.position.dy,
                          left: node.position.dx)),
                ],
              );
            },
          ),
        ));
      },
    );
  }
}
