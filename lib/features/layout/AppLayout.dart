import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/features/appPreview/AppActions/AppActions.dart';
import 'package:flutter_app/features/appPreview/AppPreview.dart';
import 'package:flutter_app/features/editProps/EditProps.dart';
import 'package:flutter_app/features/layout/PlayModeSwitch.dart';
import 'package:flutter_app/features/schemaInteractions/Screens.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/toolbox/Toolbox.dart';
import 'package:flutter_app/store/schema/BottomNavigationStore.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_app/store/schema/ScreensStore.dart';
import 'package:flutter_app/store/userActions/CurrentScreen.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AppLayout extends StatefulWidget {
  @override
  _AppLayoutState createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  SchemaStore schemaStore;
  UserActions userActions;
  CurrentScreen currentScreen;
  ScreensStore screensStore;
  BottomNavigationStore bottomNavigationStore;
  bool isPlayMode;
  FocusNode _focusNode;
  FocusAttachment _focusNodeAttachment;
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    schemaStore = SchemaStore(components: []);
    currentScreen = CurrentScreen(schemaStore);
    screensStore = ScreensStore();
    bottomNavigationStore = BottomNavigationStore();
    screensStore.createScreen(schemaStore);
    final screens = Screens(screensStore, currentScreen);
    userActions = UserActions(
        screens: screens, bottomNavigationStore: bottomNavigationStore);
    isPlayMode = false;
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
    _focusNodeAttachment = _focusNode.attach(context, onKey: _handleKeyPress);
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus != _focused) {
      setState(() {
        _focused = _focusNode.hasFocus;
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
                child: Toolbox(userActions: userActions),
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
                width: 300,
                child: GestureDetector(
                  onTap: () {
                    if (_focused) {
                      _focusNode.unfocus();
                    }
                  },
                  child: Container(
                    child: Center(
                      child: Observer(
                        builder: (context) => EditProps(
                          userActions: userActions,
                          selectedNode: userActions.selectedNode(),
                          screens: userActions.screens.all.screens,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: MyColors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
