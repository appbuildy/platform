import 'package:flutter/material.dart';
import 'package:flutter_app/features/appPreview/AppTabs.dart';
import 'package:flutter_app/features/schemaInteractions/GuidelinesManager/GuidelinesManager.dart';
import 'package:flutter_app/features/schemaInteractions/GuidelinesManager/Rays.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/Functionable.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/widgetTransformaions/WidgetPositionAfterDropOnPreview.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

enum SideEnum { topLeft, topRight, bottomRight, bottomLeft }

class AppPreview extends StatefulWidget {
  final UserActions userActions;
  final bool isPlayMode;
  final bool isPreview;
  final Function selectPlayModeToFalse;
  final Function selectStateToLayout;
  final FocusNode focusNode;

  const AppPreview({
    Key key,
    this.userActions,
    this.isPlayMode,
    this.selectPlayModeToFalse,
    this.isPreview = false,
    this.selectStateToLayout,
    this.focusNode,
  }): super(key: key);

  @override
  _AppPreviewState createState() => _AppPreviewState();
}

class _AppPreviewState extends State<AppPreview> {
  UserActions userActions;

  @override
  void initState() {
    super.initState();
    userActions = widget.userActions;
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
                  node = SchemaNode.resizeTop(
                      node: node,
                      delta: details.delta.dy,
                      screenSize: userActions.screens.currentScreenWorkspaceSize.dy,
                  );
                  node = SchemaNode.resizeLeft(
                    node: node,
                    delta: details.delta.dx,
                    screenSize: userActions.screens.currentScreenWorkspaceSize.dx,
                  );

                  userActions.repositionAndResize(node, isAddedToDoneActions: false);
                },
                child: Cursor(cursor: CursorEnum.nwseResize, child: circle),
              ),
            ),
            Positioned(
              top: -2,
              right: -2,
              child: GestureDetector(
                onPanUpdate: (details) {
                  node = SchemaNode.resizeTop(
                    node: node,
                    delta: details.delta.dy,
                    screenSize: userActions.screens.currentScreenWorkspaceSize.dy,
                  );
                  node = SchemaNode.resizeRight(
                    node: node,
                    delta: details.delta.dx,
                    screenSize: userActions.screens.currentScreenWorkspaceSize.dx,
                  );

                  userActions.repositionAndResize(node, isAddedToDoneActions: false);
                },
                child: Cursor(cursor: CursorEnum.neswResize, child: circle),
              ),
            ),
            Positioned(
              bottom: -2,
              right: -2,
              child: GestureDetector(
                onPanUpdate: (details) {
                  node = SchemaNode.resizeBottom(
                    node: node,
                    delta: details.delta.dy,
                    screenSize: userActions.screens.currentScreenWorkspaceSize.dy,
                  );
                  node = SchemaNode.resizeRight(
                    node: node,
                    delta: details.delta.dx,
                    screenSize: userActions.screens.currentScreenWorkspaceSize.dx,
                  );

                  userActions.repositionAndResize(node, isAddedToDoneActions: false);
                },
                child: Cursor(cursor: CursorEnum.nwseResize, child: circle),
              ),
            ),
            Positioned(
              bottom: -2,
              left: -2,
              child: GestureDetector(
                onPanUpdate: (details) {
                  node = SchemaNode.resizeBottom(
                    node: node,
                    delta: details.delta.dy,
                    screenSize: userActions.screens.currentScreenWorkspaceSize.dy,
                  );
                  node = SchemaNode.resizeLeft(
                    node: node,
                    delta: details.delta.dx,
                    screenSize: userActions.screens.currentScreenWorkspaceSize.dx,
                  );

                  userActions.repositionAndResize(node, isAddedToDoneActions: false);
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
                  node = SchemaNode.resizeTop(
                      node: node,
                      delta: details.delta.dy,
                      screenSize: userActions.screens.currentScreenWorkspaceSize.dy,
                  );

                  if (details.delta.dy != 0) {
                    List<Ray> horizontalRays = Ray.getOrientedRays(
                        startPosition: node.position.dy,
                        objectSize: node.size.dy,
                        raysOrientation: OrientationTypes.horizontal);

                    userActions.screens.current.guidelineManager.searchNearestHorizontalOnDirectionGuidelineFromRays(
                      rays: horizontalRays,
                      direction: details.delta.dy > 0 ? MoveDirections.forward : MoveDirections.backward,
                    );
                  }

                  userActions.repositionAndResize(node, isAddedToDoneActions: false);
                },
                child: Cursor(
                  cursor: CursorEnum.nsResize,
                  child: Container(
                    width: node.size.dx,
                    height: 10,
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(width: 1, color: MyColors.mainBlue),
                        ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onPanUpdate: (details) {
                  node = SchemaNode.resizeRight(
                    node: node,
                    delta: details.delta.dx,
                    screenSize: userActions.screens.currentScreenWorkspaceSize.dx,
                  );

                  userActions.repositionAndResize(node, isAddedToDoneActions: false);
                },
                child: Cursor(
                  cursor: CursorEnum.ewResize,
                  child: Container(
                    width: 10,
                    height: node.size.dy,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(width: 1, color: MyColors.mainBlue),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: GestureDetector(
                onPanUpdate: (details) {
                  node = SchemaNode.resizeBottom(
                    node: node,
                    delta: details.delta.dy,
                    screenSize: widget.userActions.screens.currentScreenWorkspaceSize.dy,
                  );

                  userActions.repositionAndResize(node, isAddedToDoneActions: false);
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
                  node = SchemaNode.resizeLeft(
                    node: node,
                    delta: details.delta.dx,
                    screenSize: userActions.screens.currentScreenWorkspaceSize.dx,
                  );

                  userActions.repositionAndResize(node, isAddedToDoneActions: false);
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

            node = SchemaNode.magnetHorizontalMove(
              node: node,
              deltaDx: details.delta.dx,
              screenSizeDx: userActions.screens.currentScreenWorkspaceSize.dx,
              guidelinesManager: userActions.screens.current.guidelineManager,
            );

            node = SchemaNode.magnetVerticalMove(
              node: node,
              deltaDy: details.delta.dy,
              screenSizeDy: userActions.screens.currentScreenWorkspaceSize.dy,
              guidelinesManager: userActions.screens.current.guidelineManager,
            );

            userActions.repositionAndResize(node, isAddedToDoneActions: false);
          },
          onPanEnd: (_) {
            userActions.currentScreen.guidelineManager.foundGuidelines.clear();
            userActions.rerenderNode();
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
            .calculate(userActions.screens.currentScreenWorkspaceSize.dx, widget.userActions.screens.currentScreenWorkspaceSize.dy, details.data.size);
        userActions.placeWidget(details.data, newPosition);
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
          scale = widget.isPreview
              ? 1
              : heightScaled < widthScaled
                  ? heightScaled
                  : widthScaled;
        }

        return Observer(builder: (context) {
          final theme = userActions.currentTheme;

          return Transform.scale(
            scale: scale,
            alignment: Alignment.topCenter,
            child: Container(
              width: userActions.screens.currentScreenWorkspaceSize.dx + 4,
              // 4px is for border (2 px on both sides)
              height: userActions.screens.currentScreenWorkspaceSize.dy + userActions.screens.screenTabsHeight + 4,
              // 4px is for border (2 px on both sides)
              decoration: BoxDecoration(
                  color: userActions.screens.current.backgroundColor.color,
                  borderRadius: widget.isPreview
                      ? BorderRadius.zero
                      : BorderRadius.circular(40.0),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 0,
                        blurRadius: 20,
                        offset: Offset(0, 2),
                        color: MyColors.black.withOpacity(0.15))
                  ],
                  border: widget.isPreview
                      ? Border()
                      : Border.all(width: 2, color: MyColors.black)),
              child: ClipRRect(
                borderRadius: widget.isPreview
                    ? BorderRadius.zero
                    : BorderRadius.circular(39.0),
                child: Stack(
                  textDirection: TextDirection.ltr,
                  children: [
                    ...userActions.screens.current.guidelineManager.buildMagnetLines(
                        screenSize: Offset(widget.userActions.screens.currentScreenWorkspaceSize.dx, widget.userActions.screens.currentScreenWorkspaceSize.dy)
                    ),
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
                    widget.isPreview
                        ? Container()
                        : Positioned(
                            top: 0,
                            left: 0,
                            child: Image.network(
                                'assets/icons/meta/status-bar.svg')),
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
                                width: userActions.screens.currentScreenWorkspaceSize.dx,
                                height: userActions.screens.screenTabsHeight,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: widget.isPreview
                                      ? BorderRadius.zero
                                      : BorderRadius.only(
                                          bottomLeft: Radius.circular(37.0),
                                          bottomRight: Radius.circular(37.0)),
                                ),
                              ),
                            )
                          : Container(),
                    ),
                    widget.isPreview
                        ? Container()
                        : Align(
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
