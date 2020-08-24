import 'package:flutter/material.dart';
import 'package:flutter_app/features/appPreview/AppPreview.dart';
import 'package:flutter_app/features/editProps/EditProps.dart';
import 'package:flutter_app/features/schemaInteractions/Screens.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/toolbox/Toolbox.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_app/store/schema/ScreensStore.dart';
import 'package:flutter_app/store/userActions/CurrentScreen.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  child: Center(child: Toolbox()),
                  decoration: BoxDecoration(
                      color: Color(0xFFEAEAEA),
                      border: Border(
                          right: BorderSide(width: 1, color: Colors.black))),
                ),
              ),
              Flexible(
                flex: 2,
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
                                },
                                child: Text('Add Screen')),
                            MaterialButton(
                                onPressed: () {
                                  userActions.screens.previousScreen();
                                },
                                child: Text('Previous Screen')),
                            MaterialButton(
                                onPressed: () {
                                  userActions.screens.nextScreen();
                                },
                                child: Text('Next screen')),
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
              Flexible(
                flex: 1,
                child: Container(
                  child: Center(
                    child: Observer(
                      builder: (context) => EditProps(
                          userActions: userActions,
                          selectedNode: userActions.selectedNode()),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Color(0xFFEAEAEA),
                      border: Border(
                          left: BorderSide(width: 1, color: Colors.black))),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
