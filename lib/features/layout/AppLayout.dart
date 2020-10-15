import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/features/appPreview/AppActions/AppActions.dart';
import 'package:flutter_app/features/appPreview/AppPreview.dart';
import 'package:flutter_app/features/entities/Project.dart';
import 'package:flutter_app/features/layout/MAIN_UNIQUE_KEY.dart';
import 'package:flutter_app/features/layout/PlayModeSwitch.dart';
import 'package:flutter_app/features/rightToolbox/RightToolbox.dart';
import 'package:flutter_app/features/schemaInteractions/Screens.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/toolbox/Toolbox.dart';
import 'package:flutter_app/features/toolbox/ToolboxMenu.dart';
import 'package:flutter_app/store/schema/BottomNavigationStore.dart';
import 'package:flutter_app/store/schema/CurrentUserStore.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_app/store/schema/ScreensStore.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/AppThemeStore.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_app/store/userActions/CurrentScreen.dart';
import 'package:flutter_app/ui/MyColors.dart';

class AppLayout extends StatefulWidget {
  @override
  _AppLayoutState createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  UserActions userActions;
  bool isPlayMode;
  FocusNode _focusNode;
  FocusAttachment _focusNodeAttachment;
  bool _focused = false;
  ToolboxStates toolboxState;
  Project project;

  @override
  void initState() {
    super.initState();
    final SchemaStore schemaStore = SchemaStore(name: 'Home', components: [], id: MAIN_UNIQUE_KEY);

    final CurrentScreen currentScreen = CurrentScreen(schemaStore);
    final ScreensStore screensStore = ScreensStore();
    screensStore.createScreen(schemaStore);
    final screens = Screens(screensStore, currentScreen);

    final BottomNavigationStore bottomNavigationStore = BottomNavigationStore();

    final AppThemeStore themeStore = AppThemeStore();

    final CurrentUserStore currentUserStore = CurrentUserStore();

    userActions = UserActions(
        currentUserStore: currentUserStore,
        screens: screens,
        bottomNavigationStore: bottomNavigationStore,
        themeStore: themeStore
    );

    userActions.setTheme(MyThemes.allThemes['blue']);

    isPlayMode = false;
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
    _focusNodeAttachment = _focusNode.attach(context, onKey: _handleKeyPress);
    toolboxState = ToolboxStates.layout;
    userActions.updateRemoteAttributeValues();
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
        userActions.undo();
        return true;
      }

      final selected = userActions.selectedNode();
      if (selected == null) {
        return false;
      }

      if (e.logicalKey == LogicalKeyboardKey.backspace) {
        userActions.deleteNode(selected);
      } else if (e.logicalKey == LogicalKeyboardKey.keyD && e.isMetaPressed) {
        userActions.copyNode(selected);
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

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (_focused) {
                    _focusNode.unfocus();
                  }
                },
                child: Toolbox(
                    // currentUserStore: currentUserStore,
                    toolboxState: toolboxState,
                    selectState: selectState,
                    userActions: userActions),
              ),
              Flexible(
                child: GestureDetector(
                  onTap: () {
                    if (!_focused) {
                      _focusNode.requestFocus();
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppActions(userActions: userActions),
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
                                          isPlayMode: isPlayMode,
                                          selectStateToLayout: () {
                                            selectState(ToolboxStates.layout);
                                          },
                                          userActions: userActions,
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
                                                userActions
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
              ),
              Container(
                child: GestureDetector(
                  onTap: () {
                    if (_focused) {
                      _focusNode.unfocus();
                    }
                  },
                  child: RightToolbox(
                      toolboxState: toolboxState,
                      selectState: selectState,
                      userActions: userActions),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
