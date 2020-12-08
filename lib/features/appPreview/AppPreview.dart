import 'package:flutter/material.dart';
import 'package:flutter_app/features/appPreview/AppTabs.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/Functionable.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/widgetTransformaions/WidgetPositionAfterDropOnPreview.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/utils/DeltaPanDetector.dart';
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
  }) : super(key: key);

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

    final List<Widget> dots = isSelected
        ? [
            Positioned(
              top: -2,
              left: -2,
              child: DeltaFromAnchorPointPanDetector(
                onPanUpdate: (delta) {
                  final double startDy = node.position.dy;
                  final double startDx = node.position.dx;

                  node = SchemaNode.magnetTopResize(
                    node: node,
                    deltaDy: delta.dy,
                    screenSizeDy:
                        userActions.screens.currentScreenWorkspaceSize.dy,
                    guidelinesManager:
                        userActions.screens.current.guidelineManager,
                  );
                  node = SchemaNode.magnetLeftResize(
                    node: node,
                    deltaDx: delta.dx,
                    screenSizeDx:
                        userActions.screens.currentScreenWorkspaceSize.dx,
                    guidelinesManager:
                        userActions.screens.current.guidelineManager,
                  );

                  userActions.repositionAndResize(node,
                      isAddedToDoneActions: false);

                  final double endDy = node.position.dy;
                  final double endDx = node.position.dx;

                  return DeltaFromAnchorPointPanDetector.positionChanged(
                      dx: startDx - endDx, dy: startDy - endDy);
                },
                onPanEnd: (_) {
                  userActions.currentScreen.guidelineManager.setAllInvisible();
                  userActions.rerenderNode();
                },
                child: Cursor(
                    cursor: CursorEnum.nwseResize,
                    child: const SelectionDotWidget()),
              ),
            ),
            Positioned(
              top: -2,
              right: -2,
              child: DeltaFromAnchorPointPanDetector(
                onPanUpdate: (delta) {
                  final double startDy = node.position.dy;
                  final double startDx = node.position.dx + node.size.dx;

                  node = SchemaNode.magnetTopResize(
                    node: node,
                    deltaDy: delta.dy,
                    screenSizeDy:
                        userActions.screens.currentScreenWorkspaceSize.dy,
                    guidelinesManager:
                        userActions.screens.current.guidelineManager,
                  );
                  node = SchemaNode.magnetRightResize(
                    node: node,
                    deltaDx: delta.dx,
                    screenSizeDx:
                        userActions.screens.currentScreenWorkspaceSize.dx,
                    guidelinesManager:
                        userActions.screens.current.guidelineManager,
                  );

                  userActions.repositionAndResize(node,
                      isAddedToDoneActions: false);

                  final double endDy = node.position.dy;
                  final double endDx = node.position.dx + node.size.dx;
                  return DeltaFromAnchorPointPanDetector.positionChanged(
                      dx: startDx - endDx, dy: startDy - endDy);
                },
                onPanEnd: (_) {
                  userActions.currentScreen.guidelineManager.setAllInvisible();
                  userActions.rerenderNode();
                },
                child: Cursor(
                    cursor: CursorEnum.neswResize,
                    child: const SelectionDotWidget()),
              ),
            ),
            Positioned(
              bottom: -2,
              right: -2,
              child: DeltaFromAnchorPointPanDetector(
                onPanUpdate: (delta) {
                  final double startDx = node.position.dx + node.size.dx;
                  final double startDy = node.position.dy + node.size.dy;

                  node = SchemaNode.magnetBottomResize(
                    node: node,
                    deltaDy: delta.dy,
                    screenSizeDy:
                        userActions.screens.currentScreenWorkspaceSize.dy,
                    guidelinesManager:
                        userActions.screens.current.guidelineManager,
                  );
                  node = SchemaNode.magnetRightResize(
                    node: node,
                    deltaDx: delta.dx,
                    screenSizeDx:
                        userActions.screens.currentScreenWorkspaceSize.dx,
                    guidelinesManager:
                        userActions.screens.current.guidelineManager,
                  );

                  userActions.repositionAndResize(node,
                      isAddedToDoneActions: false);

                  final double endDx = node.position.dx + node.size.dx;
                  final double endDy = node.position.dy + node.size.dy;
                  return DeltaFromAnchorPointPanDetector.positionChanged(
                      dx: startDx - endDx, dy: startDy - endDy);
                },
                onPanEnd: (_) {
                  userActions.currentScreen.guidelineManager.setAllInvisible();
                  userActions.rerenderNode();
                },
                child: Cursor(
                  cursor: CursorEnum.nwseResize,
                  child: const SelectionDotWidget(),
                ),
              ),
            ),
            Positioned(
              bottom: -2,
              left: -2,
              child: DeltaFromAnchorPointPanDetector(
                onPanUpdate: (delta) {
                  final double startDx = node.position.dx;
                  final double startDy = node.position.dy + node.size.dy;

                  node = SchemaNode.magnetBottomResize(
                    node: node,
                    deltaDy: delta.dy,
                    screenSizeDy:
                        userActions.screens.currentScreenWorkspaceSize.dy,
                    guidelinesManager:
                        userActions.screens.current.guidelineManager,
                  );
                  node = SchemaNode.magnetLeftResize(
                    node: node,
                    deltaDx: delta.dx,
                    screenSizeDx:
                        userActions.screens.currentScreenWorkspaceSize.dx,
                    guidelinesManager:
                        userActions.screens.current.guidelineManager,
                  );

                  userActions.repositionAndResize(node,
                      isAddedToDoneActions: false);

                  final double endDx = node.position.dx;
                  final double endDy = node.position.dy + node.size.dy;
                  return DeltaFromAnchorPointPanDetector.positionChanged(
                      dx: startDx - endDx, dy: startDy - endDy);
                },
                onPanEnd: (_) {
                  userActions.currentScreen.guidelineManager.setAllInvisible();
                  userActions.rerenderNode();
                },
                child: Cursor(
                  cursor: CursorEnum.neswResize,
                  child: const SelectionDotWidget(),
                ),
              ),
            ),
          ]
        : [Container()];

    final lines = isSelected
        ? [
            Positioned(
              top: 0,
              left: 0,
              child: DeltaFromAnchorPointPanDetector(
                onPanUpdate: (Offset delta) {
                  final double startDy = node.position.dy;

                  node = SchemaNode.magnetTopResize(
                    node: node,
                    deltaDy: delta.dy,
                    screenSizeDy:
                        userActions.screens.currentScreenWorkspaceSize.dy,
                    guidelinesManager:
                        userActions.screens.current.guidelineManager,
                  );

                  userActions.repositionAndResize(node,
                      isAddedToDoneActions: false);

                  final double endDy = node.position.dy;
                  return DeltaFromAnchorPointPanDetector.positionChanged(
                      dy: startDy - endDy);
                },
                onPanEnd: (_) {
                  userActions.currentScreen.guidelineManager.setAllInvisible();
                  userActions.rerenderNode();
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
              child: DeltaFromAnchorPointPanDetector(
                onPanUpdate: (delta) {
                  final double startDx = node.position.dx + node.size.dx;

                  node = SchemaNode.magnetRightResize(
                    node: node,
                    deltaDx: delta.dx,
                    screenSizeDx:
                        userActions.screens.currentScreenWorkspaceSize.dx,
                    guidelinesManager:
                        userActions.screens.current.guidelineManager,
                  );

                  userActions.repositionAndResize(node,
                      isAddedToDoneActions: false);

                  final double endDx = node.position.dx + node.size.dx;
                  return DeltaFromAnchorPointPanDetector.positionChanged(
                      dx: startDx - endDx);
                },
                onPanEnd: (_) {
                  userActions.currentScreen.guidelineManager.setAllInvisible();
                  userActions.rerenderNode();
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
              child: DeltaFromAnchorPointPanDetector(
                onPanUpdate: (delta) {
                  final double startDy = node.position.dy + node.size.dy;

                  node = SchemaNode.magnetBottomResize(
                    node: node,
                    deltaDy: delta.dy,
                    screenSizeDy:
                        userActions.screens.currentScreenWorkspaceSize.dy,
                    guidelinesManager:
                        userActions.screens.current.guidelineManager,
                  );

                  userActions.repositionAndResize(node,
                      isAddedToDoneActions: false);

                  final double endDy = node.position.dy + node.size.dy;
                  return DeltaFromAnchorPointPanDetector.positionChanged(
                      dy: startDy - endDy);
                },
                onPanEnd: (_) {
                  userActions.currentScreen.guidelineManager.setAllInvisible();
                  userActions.rerenderNode();
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
              child: DeltaFromAnchorPointPanDetector(
                onPanUpdate: (delta) {
                  final double startDx = node.position.dx;
                  node = SchemaNode.magnetLeftResize(
                    node: node,
                    deltaDx: delta.dx,
                    screenSizeDx:
                        userActions.screens.currentScreenWorkspaceSize.dx,
                    guidelinesManager:
                        userActions.screens.current.guidelineManager,
                  );

                  userActions.repositionAndResize(node,
                      isAddedToDoneActions: false);

                  final double endDx = node.position.dx;
                  return DeltaFromAnchorPointPanDetector.positionChanged(
                      dx: startDx - endDx);
                },
                onPanEnd: (_) {
                  userActions.currentScreen.guidelineManager.setAllInvisible();
                  userActions.rerenderNode();
                },
                child: Cursor(
                  cursor: CursorEnum.ewResize,
                  child: Container(
                    width: 10,
                    height: node.size.dy,
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(width: 1, color: MyColors.mainBlue),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]
        : [Container()];

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        DeltaFromAnchorPointPanDetector(
          onPanUpdate: (delta) {
            if (!isSelected) {
              userActions.selectNodeForEdit(node);
            }

            final startDx = node.position.dx;
            final startDy = node.position.dy;

            node = SchemaNode.magnetHorizontalMove(
              node: node,
              deltaDx: delta.dx,
              screenSizeDx: userActions.screens.currentScreenWorkspaceSize.dx,
              guidelinesManager: userActions.screens.current.guidelineManager,
            );

            node = SchemaNode.magnetVerticalMove(
              node: node,
              deltaDy: delta.dy,
              screenSizeDy: userActions.screens.currentScreenWorkspaceSize.dy,
              guidelinesManager: userActions.screens.current.guidelineManager,
            );

            userActions.repositionAndResize(node, isAddedToDoneActions: false);

            final endDx = node.position.dx;
            final endDy = node.position.dy;
            return DeltaFromAnchorPointPanDetector.positionChanged(
                dx: startDx - endDx, dy: startDy - endDy);
          },
          onPanEnd: (_) {
            userActions.currentScreen.guidelineManager.setAllInvisible();
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
            .calculate(
                userActions.screens.currentScreenWorkspaceSize.dx,
                widget.userActions.screens.currentScreenWorkspaceSize.dy,
                details.data.size);
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
              height: userActions.screens.currentScreenWorkspaceSize.dy +
                  userActions.screens.screenTabsHeight +
                  4,
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
                    ...userActions.currentScreen.guidelineManager.buildAllLines(
                        screenSize: widget
                            .userActions.screens.currentScreenWorkspaceSize),
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
                                      )),
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
                                child: AppTabs(
                                  selectedScreenId:
                                      userActions.currentScreen.id,
                                  tabs: userActions.bottomNavigation.tabs,
                                  theme: userActions.currentTheme,
                                  onTap: (tab) {
                                    userActions.screens.selectById(tab.target);
                                    userActions.selectNodeForEdit(null);
                                  },
                                ),
                                width: userActions
                                    .screens.currentScreenWorkspaceSize.dx,
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

const double _kDotSize = 11;

class SelectionDotWidget extends StatelessWidget {
  const SelectionDotWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(
          width: 2,
          color: MyColors.mainBlue,
        ),
      ),
      child: SizedBox(
        height: _kDotSize,
        width: _kDotSize,
      ),
    );
  }
}
