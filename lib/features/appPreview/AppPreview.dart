import 'package:flutter/material.dart';
import 'package:flutter_app/features/appPreview/AppTabs.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/Functionable.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/widgetTransformaions/WidgetPositionAfterDropOnPreview.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/utils/Debouncer.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

enum SideEnum { topLeft, topRight, bottomRight, bottomLeft }

class AppPreview extends StatefulWidget {
  final UserActions userActions;
  final bool isPlayMode;
  final Function selectPlayModeToFalse;
  final Function selectStateToLayout;
  final FocusNode focusNode;

  const AppPreview({
    Key key,
    this.userActions,
    this.isPlayMode,
    this.selectPlayModeToFalse,
    this.selectStateToLayout,
    this.focusNode,
  }): super(key: key);

  @override
  _AppPreviewState createState() => _AppPreviewState();
}

class _AppPreviewState extends State<AppPreview> {
  UserActions userActions;
  // Debouncer<SchemaNode> debouncer;

  @override
  void initState() {
    super.initState();
    userActions = widget.userActions;
  }

  double constrainPosition({
    @required double size,
    @required double value,
    @required double position,
    @required double max,
    bool isDisableWhenMin = false,
  }) {
    if (isDisableWhenMin && size <= 30.0) {
      return position;
    }

    if (value + position <= 0) {
      return 0;
    } else if (value + position + size > max) {
      return (max - size);
    }

    return value + position;
  }

  double constrainSize({
    @required double size,
    @required double value,
    @required double position,
    @required double max,
    bool isSub = false,
    double prevPosition,
  }) {
    final double realValue = isSub ? value * -1 : value;
    final int maxInt = max.round();

    if (isSub && position <= 0) {
      if (realValue < 0) {
        return size + realValue;
      }

      return size +
          prevPosition; // прыжок происходит потому что position уже поменялся и равен 0, а для сайза в таком случае value не прикладывается
    }

    if (size + realValue + position > maxInt) {
      return max - position;
    } else if (size + realValue <= 30.0) {
      return 30.0;
    }
    return size + realValue;
  }

  double get maxHeight => userActions.currentScreen.bottomTabsVisible
      ? userActions.screens.screenHeight + userActions.screens.screenTabsHeight
      : userActions.screens.screenHeight;

  void handleSizeChange(
      {@required SchemaNode node, Offset delta, SideEnum side}) {
    if (side == SideEnum.topLeft) {
      final posX = node.position.dx;
      final posY = node.position.dy;

      node.position = Offset(
        constrainPosition(
            position: node.position.dx,
            value: delta.dx,
            size: node.size.dx,
            max: userActions.screens.screenWidth,
            isDisableWhenMin: true),
        constrainPosition(
            position: node.position.dy,
            value: delta.dy,
            size: node.size.dy,
            max: maxHeight,
            isDisableWhenMin: true),
      );
      node.size = Offset(
          constrainSize(
            size: node.size.dx,
            position: node.position.dx,
            max: userActions.screens.screenWidth,
            value: delta.dx,
            isSub: true,
            prevPosition: posX,
          ),
          constrainSize(
            size: node.size.dy,
            position: node.position.dy,
            max: maxHeight,
            value: delta.dy,
            isSub: true,
            prevPosition: posY,
          ));
    } else if (side == SideEnum.topRight) {
      final posY = node.position.dy;

      node.position = Offset(
        node.position.dx,
        constrainPosition(
            position: node.position.dy,
            value: delta.dy,
            size: node.size.dy,
            max: maxHeight,
            isDisableWhenMin: true),
      );
      node.size = Offset(
          constrainSize(
            size: node.size.dx,
            position: node.position.dx,
            max: userActions.screens.screenWidth,
            value: delta.dx,
          ),
          constrainSize(
            size: node.size.dy,
            position: node.position.dy,
            max: maxHeight,
            value: delta.dy,
            isSub: true,
            prevPosition: posY,
          ));
    } else if (side == SideEnum.bottomLeft) {
      final posX = node.position.dx;

      node.position = Offset(
        constrainPosition(
          position: node.position.dx,
          value: delta.dx,
          size: node.size.dx,
          max: userActions.screens.screenWidth,
          isDisableWhenMin: true,
        ),
        node.position.dy,
      );

      node.size = Offset(
          constrainSize(
              size: node.size.dx,
              position: node.position.dx,
              max: userActions.screens.screenWidth,
              value: delta.dx,
              isSub: true,
              prevPosition: posX),
          constrainSize(
            size: node.size.dy,
            position: node.position.dy,
            max: maxHeight,
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
            max: userActions.screens.screenWidth,
            value: delta.dx,
          ),
          constrainSize(
            size: node.size.dy,
            position: node.position.dy,
            max: maxHeight,
            value: delta.dy,
          ));
    }

    userActions.repositionAndResize(node, false);

    // debouncer.run(
    //     () => userActions.repositionAndResize(node, true, debouncer.prevValue),
    //     node.copy(),
    // );
  }

  Widget renderWithSelected({SchemaNode node}) {
    final isSelected = userActions.selectedNode() != null &&
        userActions.selectedNode().id == node.id;

    final Widget circle = Container(
      width: 11,
      height: 11,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: MyColors.white,
          border: Border.all(width: 2, color: MyColors.mainBlue)),
    );

    final List<Widget> dots = isSelected
        ? [
            Positioned(
              top: -2,
              left: -2,
              child: GestureDetector(
                onPanUpdate: (details) {
                  handleSizeChange(
                      node: node, delta: details.delta, side: SideEnum.topLeft);
                },
                child: Cursor(cursor: CursorEnum.nwseResize, child: circle),
              ),
            ),
            Positioned(
              top: -2,
              right: -2,
              child: GestureDetector(
                onPanUpdate: (details) {
                  handleSizeChange(
                      node: node,
                      delta: details.delta,
                      side: SideEnum.topRight);
                },
                child: Cursor(cursor: CursorEnum.neswResize, child: circle),
              ),
            ),
            Positioned(
              bottom: -2,
              right: -2,
              child: GestureDetector(
                onPanUpdate: (details) {
                  handleSizeChange(
                      node: node,
                      delta: details.delta,
                      side: SideEnum.bottomRight);
                },
                child: Cursor(cursor: CursorEnum.nwseResize, child: circle),
              ),
            ),
            Positioned(
              bottom: -2,
              left: -2,
              child: GestureDetector(
                onPanUpdate: (details) {
                  handleSizeChange(
                      node: node,
                      delta: details.delta,
                      side: SideEnum.bottomLeft);
                },
                child: Cursor(cursor: CursorEnum.neswResize, child: circle),
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
                  final posY = node.position.dy;

                  node.position = Offset(
                    node.position.dx,
                    constrainPosition(
                        position: node.position.dy,
                        value: details.delta.dy,
                        size: node.size.dy,
                        max: maxHeight,
                        isDisableWhenMin: true),
                  );

                  node.size = Offset(
                      node.size.dx,
                      constrainSize(
                        size: node.size.dy,
                        position: node.position.dy,
                        max: maxHeight,
                        value: details.delta.dy,
                        isSub: true,
                        prevPosition: posY,
                      ));

                  userActions.repositionAndResize(node, false);

                  // debouncer.run(
                  //     () => userActions.repositionAndResize(
                  //         node, true, debouncer.prevValue),
                  //     node.copy());
                },
                child: Cursor(
                  cursor: CursorEnum.nsResize,
                  child: Container(
                    width: node.size.dx,
                    height: 10,
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                width: 1, color: MyColors.mainBlue))),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onPanUpdate: (details) {
                  final posX = node.position.dx;

                  node.position = Offset(
                    node.position.dx,
                    node.position.dy,
                  );
                  node.size = Offset(
                    constrainSize(
                      size: node.size.dx,
                      position: node.position.dx,
                      max: userActions.screens.screenWidth,
                      value: details.delta.dx,
                      prevPosition: posX,
                    ),
                    node.size.dy,
                  );
                  userActions.repositionAndResize(node, false);

                  // debouncer.run(
                  //     () => userActions.repositionAndResize(
                  //         node, true, debouncer.prevValue),
                  //     node.copy()
                  // );
                },
                child: Cursor(
                  cursor: CursorEnum.ewResize,
                  child: Container(
                      width: 10,
                      height: node.size.dy,
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                  width: 1, color: MyColors.mainBlue)))),
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
                        max: maxHeight,
                        value: details.delta.dy,
                      ));
                  userActions.repositionAndResize(node, false);

                  // debouncer.run(
                  //     () => userActions.repositionAndResize(
                  //         node, true, debouncer.prevValue),
                  //     node.copy());
                },
                child: Cursor(
                  cursor: CursorEnum.nsResize,
                  child: Container(
                      width: node.size.dx,
                      height: 10,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1, color: MyColors.mainBlue)))),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: GestureDetector(
                onPanUpdate: (details) {
                  final posX = node.position.dx;

                  node.position = Offset(
                      constrainPosition(
                          position: node.position.dx,
                          value: details.delta.dx,
                          size: node.size.dx,
                          max: userActions.screens.screenWidth,
                          isDisableWhenMin: true),
                      node.position.dy);

                  node.size = Offset(
                      constrainSize(
                        size: node.size.dx,
                        position: node.position.dx,
                        max: userActions.screens.screenWidth,
                        value: details.delta.dx,
                        isSub: true,
                        prevPosition: posX,
                      ),
                      node.size.dy);
                  userActions.repositionAndResize(node, false);

                  // debouncer.run(
                  //     () => userActions.repositionAndResize(
                  //         node, true, debouncer.prevValue),
                  //     node.copy());
                },
                child: Cursor(
                  cursor: CursorEnum.ewResize,
                  child: Container(
                      width: 10,
                      height: node.size.dy,
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  width: 1, color: MyColors.mainBlue)))),
                ),
              ),
            ),
          ]
        : [Container()];

    return Stack(
      overflow: Overflow.visible,
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onPanUpdate: (details) {
            if (!isSelected) {
              userActions.selectNodeForEdit(node);
            }

            node.position = Offset(
              constrainPosition(
                  position: node.position.dx,
                  value: details.delta.dx,
                  size: node.size.dx,
                  max: userActions.screens.screenWidth),
              constrainPosition(
                  position: node.position.dy,
                  value: details.delta.dy,
                  size: node.size.dy,
                  max: maxHeight),
            );
            userActions.repositionAndResize(node, false);

            // debouncer.run(
            //     () => userActions.repositionAndResize(
            //         node, true, debouncer.prevValue),
            //     node.copy());
          },
          child: Cursor(
            cursor: CursorEnum.move,
            child: Container(
              width: node.size.dx,
              height: node.size.dy,
              child: node.toWidget(isPlayMode: widget.isPlayMode),
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
        final newPosition = WidgetPositionAfterDropOnPreview(context, details)
            .calculate(userActions.screens.screenWidth, maxHeight, details.data.size);
        // final placedSchemaNode =
        userActions.placeWidget(details.data, newPosition);
        // debouncer =
        //     Debouncer(milliseconds: 500, prevValue: placedSchemaNode.copy());
        widget.selectPlayModeToFalse();

        widget.focusNode.requestFocus();
      },
      builder: (context, candidateData, rejectedData) {
        final height = MediaQuery.of(context).size.height;
        final width = MediaQuery.of(context).size.width;
        double scale = 1;

        final heightScaled = height / 1000;
        final widthScaled = width / 1400;

        if (height <= 899 || width <= 1140) {
          scale = heightScaled < widthScaled ? heightScaled : widthScaled;
        }

        return Observer(builder: (context) {
          final theme = userActions.currentTheme;

          return Transform.scale(
            scale: scale,
            alignment: Alignment.topCenter,
            child: Container(
              width: userActions.screens.screenWidth + 4,
              // 4px is for border (2 px on both sides)
              height: userActions.screens.screenHeight + 4,
              // 4px is for border (2 px on both sides)
              decoration: BoxDecoration(
                  color: userActions.screens.current.backgroundColor.color,
                  borderRadius: BorderRadius.circular(40.0),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 0,
                        blurRadius: 20,
                        offset: Offset(0, 2),
                        color: MyColors.black.withOpacity(0.15))
                  ],
                  border: Border.all(width: 2, color: MyColors.black)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(39.0),
                child: Stack(
                  textDirection: TextDirection.ltr,
                  children: [
                    ...userActions.screens.current.components.map((node) =>
                        Positioned(
                            child: GestureDetector(
                              onTapDown: (details) {
                                widget.focusNode.requestFocus();

                                if (widget.isPlayMode) {
                                  if (node.type == SchemaNodeType.list) {
                                    // чтобы прокидывать данные на каждый айтем листа
                                    return;
                                  }
                                  (node.actions['Tap'] as Functionable)
                                      .toFunction(userActions)();
                                } else {
                                  userActions.selectNodeForEdit(node);
                                  // debouncer = Debouncer(
                                  //     milliseconds: 500,
                                  //     prevValue: node.copy());
                                  widget
                                      .selectStateToLayout(); // select menu layout
                                }
                              },
                              child: widget.isPlayMode
                                  ? node.toWidget(
                                      isPlayMode: widget.isPlayMode,
                                      userActions: widget.userActions)
                                  : renderWithSelected(
                                      node: node,
                                    )
                            ),
                            top: node.position.dy,
                            left: node.position.dx)),
                    Positioned(
                        top: 0,
                        left: 0,
                        child:
                            Image.network('assets/icons/meta/status-bar.svg')),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: userActions.screens.current.bottomTabsVisible
                          ? Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                          width: 1,
                                          color: theme.separators.color))),
                              child: Container(
                                child: AppTabs(userActions: userActions),
                                width: userActions.screens.screenWidth,
                                height: 84,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(37.0),
                                      bottomRight: Radius.circular(37.0)),
                                ),
                              ),
                            )
                          : Container(),
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 7.0),
                          child: Container(
                            width: 134,
                            height: 5,
                            decoration: BoxDecoration(
                                color: Color(0xFF000000),
                                borderRadius: BorderRadius.circular(100)),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
