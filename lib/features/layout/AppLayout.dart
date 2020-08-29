import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/features/appPreview/AppPreview.dart';
import 'package:flutter_app/features/editProps/EditProps.dart';
import 'package:flutter_app/features/schemaInteractions/Screens.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/toolbox/Toolbox.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_app/store/schema/ScreensStore.dart';
import 'package:flutter_app/store/userActions/CurrentScreen.dart';
import 'package:flutter_app/utils/SchemaConverter.dart';
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
    screensStore.createScreen(schemaStore);
    final screens = Screens(screensStore, currentScreen);
    userActions = UserActions(screens: screens);
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
                child: Toolbox(),
              ),
              Flexible(
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    if (!_focused) {
                      _focusNode.requestFocus();
                    }
                  },
                  child: Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              MaterialButton(
                                  color: isPlayMode ? Colors.white : Colors.red,
                                  onPressed: () {
                                    setState(() {
                                      isPlayMode = false;
                                    });
                                  },
                                  child: Text('Interactive mode')),
                              MaterialButton(
                                  color: isPlayMode ? Colors.red : Colors.white,
                                  onPressed: () {
                                    setState(() {
                                      userActions.selectNodeForEdit(null);
                                      isPlayMode = true;
                                    });
                                  },
                                  child: Text('Play mode')),
                            ],
                          ),
                          Row(
                            children: [
                              MaterialButton(
                                  onPressed: () {
                                    userActions.undo();
                                  },
                                  child: Text('Undo')),
                              MaterialButton(
                                onPressed: () {},
                                child: Text('Redo'),
                              ),
                              MaterialButton(
                                  onPressed: () {
                                    userActions.screens
                                        .create(moveToNextAfterCreated: true);
                                    userActions.selectNodeForEdit(null);
                                  },
                                  child: Text('Add Screen')),
                              MaterialButton(
                                  onPressed: () {
                                    userActions.screens.previousScreen();
                                    userActions.selectNodeForEdit(null);
                                  },
                                  child: Text('Previous Screen')),
                              MaterialButton(
                                  onPressed: () {
                                    userActions.screens.nextScreen();
                                    userActions.selectNodeForEdit(null);
                                  },
                                  child: Text('Next screen')),
                              MaterialButton(
                                  onPressed: () {
                                    final json =
                                        SchemaConverter(userActions.screens.all)
                                            .toJson()
                                            .toString();
                                    print(json);
                                  },
                                  child: Text('Print Schema')),
                            ],
                          ),
                          SizedBox(
                            height: 100,
                          ),
                          Observer(
                            builder: (context) =>
                                Text(userActions.screens.current.name),
                          ),
                          AppPreview(
                            isPlayMode: isPlayMode,
                            userActions: userActions,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
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
                        color: Color(0xFFEAEAEA),
                        border: Border(
                            left: BorderSide(width: 1, color: Colors.black))),
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
