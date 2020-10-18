import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/features/appPreview/AppActions/AppActions.dart';
import 'package:flutter_app/features/appPreview/AppPreview.dart';
import 'package:flutter_app/features/entities/Project.dart';
import 'package:flutter_app/features/layout/PlayModeSwitch.dart';
import 'package:flutter_app/features/rightToolbox/RightToolbox.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/toolbox/Toolbox.dart';
import 'package:flutter_app/features/toolbox/ToolboxMenu.dart';
import 'package:flutter_app/ui/MyColors.dart';

class AppLayout extends StatefulWidget {
  final UserActions userActions;

  AppLayout({ @required this.userActions });

  @override
  _AppLayoutState createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  bool isPlayMode;
  FocusNode _focusNode;
  FocusAttachment _focusNodeAttachment;
  bool _focused = false;
  ToolboxStates toolboxState;
  Project project;

  @override
  void initState() {
    super.initState();

    isPlayMode = false;
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
    _focusNodeAttachment = _focusNode.attach(context, onKey: _handleKeyPress);
    toolboxState = ToolboxStates.layout;
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus != _focused) {
      setState(() {
        _focused = _focusNode.hasFocus;
      });
    }
  }

  void selectState(ToolboxStates newState) {
    if (newState != toolboxState) {
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

      final selected = widget.userActions.selectedNode();
      if (selected == null) {
        return false;
      }

      if (e.logicalKey == LogicalKeyboardKey.arrowUp || e.logicalKey == LogicalKeyboardKey.arrowDown) {
        final bool isUp = e.logicalKey == LogicalKeyboardKey.arrowUp;
        widget.userActions.moveSelectedNode(Offset(0, isUp ? -1 : 1));
      }

      if (e.logicalKey == LogicalKeyboardKey.arrowLeft || e.logicalKey == LogicalKeyboardKey.arrowRight) {
        final bool isLeft = e.logicalKey == LogicalKeyboardKey.arrowLeft;
        widget.userActions.moveSelectedNode(Offset(isLeft ? -1 : 1, 0));
      }

      if (e.logicalKey == LogicalKeyboardKey.backspace) {
        widget.userActions.deleteNode(selected);
      } else if (e.logicalKey == LogicalKeyboardKey.keyD && e.isMetaPressed) {
        widget.userActions.copyNode(selected);
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
    _focusNodeAttachment.reparent();

    return GestureDetector(
      onTap: () {
        _focusNode.requestFocus();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              children: [
                Toolbox(
                    toolboxState: toolboxState,
                    selectState: selectState,
                    userActions: widget.userActions),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppActions(userActions: widget.userActions),
                      Expanded(
                        child: Container(
                          color: MyColors.lightGray,
                          child: Stack(
                            overflow: Overflow.visible,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SingleChildScrollView(
                                      physics: NeverScrollableScrollPhysics(),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20.0,
                                            bottom: 20,
                                            left: 30,
                                            right: 30),
                                        child: AppPreview(
                                          focusNode: _focusNode,
                                          isPlayMode: isPlayMode,
                                          selectStateToLayout: () {
                                            selectState(ToolboxStates.layout);
                                          },
                                          userActions: widget.userActions,
                                          selectPlayModeToFalse: () {
                                            if (isPlayMode == true) {
                                              setState(() {
                                                isPlayMode = false;
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                  bottom: 13.0,
                                  left: 13.0,
                                  child: Container(
                                    width: 196,
                                    child: SingleChildScrollView(
                                      child: PlayModeSwitch(
                                          isPlayMode: isPlayMode,
                                          selectPlayMode: (bool newIsPlayMode) {
                                            setState(() {
                                              isPlayMode = newIsPlayMode;

                                              if (newIsPlayMode) {
                                                widget.userActions
                                                    .selectNodeForEdit(null);
                                              }
                                            });
                                          }),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: RightToolbox(
                      toolboxState: toolboxState,
                      selectState: selectState,
                      userActions: widget.userActions
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
