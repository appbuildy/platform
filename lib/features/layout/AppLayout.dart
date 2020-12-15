import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_app/features/appPreview/AppActions/AppActions.dart';
import 'package:flutter_app/features/appPreview/AppPreview.dart';
import 'package:flutter_app/features/layout/PlayModeSwitch.dart';
import 'package:flutter_app/features/rightToolbox/RightToolbox.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/toolbox/Toolbox.dart';
import 'package:flutter_app/features/toolbox/ToolboxMenu.dart';
import 'package:flutter_app/ui/MyColors.dart';

class AppLayout extends StatefulWidget {
  final UserAction userActions;

  AppLayout({@required this.userActions});

  @override
  _AppLayoutState createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  bool isPlayMode;
  bool isPreview;
  FocusNode _focusNode;
  FocusAttachment _focusNodeAttachment;
  bool _focused = false;
  ToolboxStates toolboxState;

  @override
  void initState() {
    super.initState();

    final isProjectPreview =
        Uri.base.queryParameters['project_preview'] != null;

    isPlayMode = isProjectPreview;
    isPreview = isProjectPreview;
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
    _focusNodeAttachment = _focusNode.attach(context, onKey: _handleKeyPress);
    toolboxState = ToolboxStates.layout;
  }

  void _handleFocusChange() {
    if (mounted && _focusNode.hasFocus != _focused) {
      setState(() {
        _focused = _focusNode.hasFocus;
      });
    }
  }

  void selectState(ToolboxStates newState) {
    if (mounted && newState != toolboxState) {
      setState(() {
        toolboxState = newState;
      });
    }
  }

  bool _handleKeyPress(FocusNode node, RawKeyEvent e) {
    if (e is RawKeyDownEvent) {
      print('got key event: ${e.logicalKey}');

      if (e.logicalKey == LogicalKeyboardKey.keyZ && e.isMetaPressed) {
        widget.userActions.undo();
        return true;
      }

      final selectedNode = widget.userActions.selectedNode();
      if (selectedNode == null) {
        return false;
      }

      if (e.logicalKey == LogicalKeyboardKey.arrowUp ||
          e.logicalKey == LogicalKeyboardKey.arrowDown) {
        final bool isUp = e.logicalKey == LogicalKeyboardKey.arrowUp;

        selectedNode.position = Offset(
            selectedNode.position.dx,
            SchemaNode.axisMove(
              axisNodePosition: selectedNode.position.dy,
              axisNodeSize: selectedNode.size.dy,
              axisDelta: isUp ? -1 : 1,
              axisScreenSize:
                  widget.userActions.screens.currentScreenWorkspaceSize.dy,
            ));

        widget.userActions
            .repositionAndResize(selectedNode, isAddedToDoneActions: false);
      }

      if (e.logicalKey == LogicalKeyboardKey.arrowLeft ||
          e.logicalKey == LogicalKeyboardKey.arrowRight) {
        final bool isLeft = e.logicalKey == LogicalKeyboardKey.arrowLeft;

        selectedNode.position = Offset(
          SchemaNode.axisMove(
            axisNodePosition: selectedNode.position.dx,
            axisNodeSize: selectedNode.size.dx,
            axisDelta: isLeft ? -1 : 1,
            axisScreenSize:
                widget.userActions.screens.currentScreenWorkspaceSize.dx,
          ),
          selectedNode.position.dy,
        );

        widget.userActions
            .repositionAndResize(selectedNode, isAddedToDoneActions: false);
      }

      if (e.logicalKey == LogicalKeyboardKey.backspace) {
        widget.userActions.deleteNode(selectedNode);
      } else if (e.logicalKey == LogicalKeyboardKey.keyD && e.isMetaPressed) {
        widget.userActions.copyNode(selectedNode);
      }

      return true;
    }
    return false;
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isPreview) {
      return SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: AppPreview(
          isPlayMode: isPlayMode,
          isPreview: isPreview,
          selectStateToLayout: () {
            selectState(ToolboxStates.layout);
          },
          userActions: widget.userActions,
          setPlayModeToFalse: () {
            if (isPlayMode == true) {
              setState(() {
                isPlayMode = false;
              });
            }
          },
        ),
      );
    }

    _focusNodeAttachment.reparent();

    return GestureDetector(
      onTap: () {
        _focusNode.requestFocus();
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Toolbox(
              toolboxState: toolboxState,
              selectState: selectState,
              userActions: widget.userActions),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppActions(userActions: widget.userActions),
                Expanded(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: MyColors.lightGray,
                    ),
                    child: Stack(
                      // clipBehavior: Clip.none,
                      children: [
                        Positioned.fill(
                          bottom: 13.0 + 36 + 24,
                          top: 13,
                          left: 13,
                          right: 13,
                          child: Align(
                              child: SingleChildScrollView(
                            physics: NeverScrollableScrollPhysics(),
                            child: AppPreview(
                              focusNode: _focusNode,
                              isPlayMode: isPlayMode,
                              selectStateToLayout: () {
                                selectState(ToolboxStates.layout);
                              },
                              userActions: widget.userActions,
                              setPlayModeToFalse: () {
                                if (isPlayMode == true) {
                                  setState(() {
                                    isPlayMode = false;
                                  });
                                }
                              },
                            ),
                          )),
                        ),
                        Positioned(
                          bottom: 13.0,
                          right: 13.0,
                          width: 180,
                          height: 36,
                          child: PlayModeSwitch(
                              isPlayMode: isPlayMode,
                              selectPlayMode: (bool newIsPlayMode) {
                                if (isPlayMode != newIsPlayMode)
                                  setState(() {
                                    isPlayMode = newIsPlayMode;

                                    if (newIsPlayMode) {
                                      widget.userActions
                                          .selectNodeForEdit(null);
                                    }
                                  });
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          RightToolbox(
              toolboxState: toolboxState,
              selectState: selectState,
              userActions: widget.userActions),
        ],
      ),
    );
  }
}
