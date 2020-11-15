import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/utils/DeltaPanDetector.dart';

import 'GuidelinesManager/GuidelinesManager.dart';

Widget renderWithSelected({
  @required SchemaNode node,
  @required Function onPanEnd,
  @required Function repositionAndResize,
  @required Offset currentScreenWorkspaceSize,
  @required bool isPlayMode,
  @required bool isSelected,
  @required Function toWidgetFunction,
  @required bool isMagnetInteraction,
  @required Function selectNodeForEdit,
}) {
  final GuidelinesManager guidelinesManager = node.parentSpawner.userActions.guidelineManager;

  final Widget circle = Container(
    width: 11,
    height: 11,
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: MyColors.white,
        border: Border.all(width: 2, color: MyColors.mainBlue)),
  );

  final List<Widget> dots = isSelected ? [
    Positioned(
      top: -2,
      left: -2,
      child: DeltaFromAnchorPointPanDetector(
        onPanUpdate: (delta) {
          final double startDy = node.position.dy;
          final double startDx = node.position.dx;

          if (isMagnetInteraction) {
            node.magnetTopResize(
              deltaDy: delta.dy,
              screenSizeDy: currentScreenWorkspaceSize.dy,
              guidelinesManager: guidelinesManager,
            );
            node.magnetLeftResize(
              deltaDx: delta.dx,
              screenSizeDx: currentScreenWorkspaceSize.dx,
              guidelinesManager: guidelinesManager,
            );
          } else {
            node.resizeTop(
              deltaDy: delta.dy,
              screenSizeDy: currentScreenWorkspaceSize.dy,
            );
            node.resizeLeft(
              deltaDx: delta.dx,
              screenSizeDx: currentScreenWorkspaceSize.dx,
            );
          }

          repositionAndResize(node, isAddedToDoneActions: false);

          final double endDy = node.position.dy;
          final double endDx = node.position.dx;

          return DeltaFromAnchorPointPanDetector.positionChanged(dx: startDx - endDx, dy: startDy - endDy);
        },
        onPanEnd: onPanEnd,
        child: Cursor(cursor: CursorEnum.nwseResize, child: circle),
      ),
    ),
    Positioned(
      top: -2,
      right: -2,
      child: DeltaFromAnchorPointPanDetector(
        onPanUpdate: (delta) {
          final double startDy = node.position.dy;
          final double startDx = node.position.dx + node.size.dx;

          if (isMagnetInteraction) {
            node.magnetTopResize(
              deltaDy: delta.dy,
              screenSizeDy: currentScreenWorkspaceSize.dy,
              guidelinesManager: guidelinesManager,
            );
            node.magnetRightResize(
              deltaDx: delta.dx,
              screenSizeDx: currentScreenWorkspaceSize.dx,
              guidelinesManager: guidelinesManager,
            );
          } else {
            node.resizeTop(
              deltaDy: delta.dy,
              screenSizeDy: currentScreenWorkspaceSize.dy,
            );
            node.resizeRight(
              deltaDx: delta.dx,
              screenSizeDx: currentScreenWorkspaceSize.dx,
            );
          }

          repositionAndResize(node, isAddedToDoneActions: false);

          final double endDy = node.position.dy;
          final double endDx = node.position.dx + node.size.dx;
          return DeltaFromAnchorPointPanDetector.positionChanged(dx: startDx - endDx, dy: startDy - endDy);
        },
        onPanEnd: onPanEnd,
        child: Cursor(cursor: CursorEnum.neswResize, child: circle),
      ),
    ),
    Positioned(
      bottom: -2,
      right: -2,
      child: DeltaFromAnchorPointPanDetector(
        onPanUpdate: (delta) {
          final double startDx = node.position.dx + node.size.dx;
          final double startDy = node.position.dy + node.size.dy;

          if (isMagnetInteraction) {
            node.magnetBottomResize(
              deltaDy: delta.dy,
              screenSizeDy: currentScreenWorkspaceSize.dy,
              guidelinesManager: guidelinesManager,
            );
            node.magnetRightResize(
              deltaDx: delta.dx,
              screenSizeDx: currentScreenWorkspaceSize.dx,
              guidelinesManager: guidelinesManager,
            );
          } else {
            node.resizeBottom(
              deltaDy: delta.dy,
              screenSizeDy: currentScreenWorkspaceSize.dy,
            );
            node.resizeRight(
              deltaDx: delta.dx,
              screenSizeDx: currentScreenWorkspaceSize.dx,
            );
          }

          repositionAndResize(node, isAddedToDoneActions: false);

          final double endDx = node.position.dx + node.size.dx;
          final double endDy = node.position.dy + node.size.dy;
          return DeltaFromAnchorPointPanDetector.positionChanged(dx: startDx - endDx, dy: startDy - endDy);
        },
        onPanEnd: onPanEnd,
        child: Cursor(cursor: CursorEnum.nwseResize, child: circle),
      ),
    ),
    Positioned(
      bottom: -2,
      left: -2,
      child: DeltaFromAnchorPointPanDetector(
        onPanUpdate: (delta) {
          final double startDx = node.position.dx;
          final double startDy = node.position.dy + node.size.dy;

          if (isMagnetInteraction) {
            node.magnetBottomResize(
              deltaDy: delta.dy,
              screenSizeDy: currentScreenWorkspaceSize.dy,
              guidelinesManager: guidelinesManager,
            );
            node.magnetLeftResize(
              deltaDx: delta.dx,
              screenSizeDx: currentScreenWorkspaceSize.dx,
              guidelinesManager: guidelinesManager,
            );
          } else {
            node.resizeBottom(
              deltaDy: delta.dy,
              screenSizeDy: currentScreenWorkspaceSize.dy,
            );
            node.resizeLeft(
              deltaDx: delta.dx,
              screenSizeDx: currentScreenWorkspaceSize.dx,
            );
          }


          repositionAndResize(node, isAddedToDoneActions: false);

          final double endDx = node.position.dx;
          final double endDy = node.position.dy + node.size.dy;
          return DeltaFromAnchorPointPanDetector.positionChanged(dx: startDx - endDx, dy: startDy - endDy);
        },
        onPanEnd: onPanEnd,
        child: Cursor(cursor: CursorEnum.neswResize, child: circle),
      ),
    ),
  ] : [Container()];

  final lines = isSelected ? [
    Positioned(
      top: 0,
      left: 0,
      child: DeltaFromAnchorPointPanDetector(
        onPanUpdate: (Offset delta) {
          final double startDy = node.position.dy;

          if (isMagnetInteraction) {
            node.magnetTopResize(
              deltaDy: delta.dy,
              screenSizeDy: currentScreenWorkspaceSize.dy,
              guidelinesManager: guidelinesManager,
            );
          } else {
            node.resizeTop(
              deltaDy: delta.dy,
              screenSizeDy: currentScreenWorkspaceSize.dy,
            );
          }

          repositionAndResize(node, isAddedToDoneActions: false);

          final double endDy = node.position.dy;
          return DeltaFromAnchorPointPanDetector.positionChanged(dy: startDy - endDy);
        },
        onPanEnd: onPanEnd,
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

          if (isMagnetInteraction) {
            node.magnetRightResize(
              deltaDx: delta.dx,
              screenSizeDx: currentScreenWorkspaceSize.dx,
              guidelinesManager: guidelinesManager,
            );
          } else {
            node.resizeRight(
              deltaDx: delta.dx,
              screenSizeDx: currentScreenWorkspaceSize.dx,
            );
          }

          repositionAndResize(node, isAddedToDoneActions: false);

          final double endDx = node.position.dx + node.size.dx;
          return DeltaFromAnchorPointPanDetector.positionChanged(dx: startDx - endDx);
        },
        onPanEnd: onPanEnd,
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

          if (isMagnetInteraction) {
            node.magnetBottomResize(
              deltaDy: delta.dy,
              screenSizeDy: currentScreenWorkspaceSize.dy,
              guidelinesManager: guidelinesManager,
            );
          } else {
            node.resizeBottom(
              deltaDy: delta.dy,
              screenSizeDy: currentScreenWorkspaceSize.dy,
            );
          }

          repositionAndResize(node, isAddedToDoneActions: false);

          final double endDy = node.position.dy + node.size.dy;
          return DeltaFromAnchorPointPanDetector.positionChanged(dy: startDy - endDy);
        },
        onPanEnd: onPanEnd,
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

          if (isMagnetInteraction) {
            node.magnetLeftResize(
              deltaDx: delta.dx,
              screenSizeDx: currentScreenWorkspaceSize.dx,
              guidelinesManager: guidelinesManager,
            );
          } else {
            node.resizeLeft(
              deltaDx: delta.dx,
              screenSizeDx: currentScreenWorkspaceSize.dx,
            );
          }

          repositionAndResize(node, isAddedToDoneActions: false);

          final double endDx = node.position.dx;
          return DeltaFromAnchorPointPanDetector.positionChanged(dx: startDx - endDx);
        },
        onPanEnd: onPanEnd,
        child: Cursor(
          cursor: CursorEnum.ewResize,
          child: Container(
            width: 10,
            height: node.size.dy,
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                    width: 1, color: MyColors.mainBlue
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  ] : [Container()];

  return Stack(
    overflow: Overflow.visible,
    alignment: Alignment.center,
    children: [
      DeltaFromAnchorPointPanDetector(
        onPanUpdate: (delta) {
          if (!isSelected) {
            selectNodeForEdit(node);
          }

          final startDx = node.position.dx;
          final startDy = node.position.dy;

          if (isMagnetInteraction) {
            node.magnetHorizontalMove(
              deltaDx: delta.dx,
              screenSizeDx: currentScreenWorkspaceSize.dx,
              guidelinesManager: guidelinesManager,
            );

            node.magnetVerticalMove(
              deltaDy: delta.dy,
              screenSizeDy: currentScreenWorkspaceSize.dy,
              guidelinesManager: guidelinesManager,
            );
          } else {
            node.move(
              delta: delta,
              screenSize: currentScreenWorkspaceSize,
            );
          }

          repositionAndResize(node, isAddedToDoneActions: false);

          final endDx = node.position.dx;
          final endDy = node.position.dy;
          return DeltaFromAnchorPointPanDetector.positionChanged(dx: startDx - endDx, dy: startDy - endDy);
        },
        onPanEnd: onPanEnd,
        child: Cursor(
          cursor: CursorEnum.move,
          child: Container(
            width: node.size.dx,
            height: node.size.dy,
            child: toWidgetFunction(isPlayMode: isPlayMode),
          ),
        ),
      ),
      ...lines,
      ...dots,
    ],
  );
}