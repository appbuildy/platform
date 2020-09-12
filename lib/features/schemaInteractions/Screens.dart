import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/schemaInteractions/BaseAction.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_app/store/schema/ScreensStore.dart';
import 'package:flutter_app/store/userActions/AddScreen.dart';
import 'package:flutter_app/store/userActions/CurrentScreen.dart';
import 'package:flutter_app/store/userActions/DeleteScreen.dart';

class Screens {
  CurrentScreen _current;
  ScreensStore all;
  Screens(this.all, this._current);

  BaseAction create({moveToLastAfterCreated = false}) {
    final action = AddScreen(screensStore: all);
    action.execute();

    if (moveToLastAfterCreated) lastScreen();
    return action;
  }

  BaseAction delete(SchemaStore deletingScreen) {
    final action = DeleteScreen(screensStore: all);
    action.execute(deletingScreen: deletingScreen);

//    if (moveToLastAfterCreated) lastScreen();
    return action;
  }

  void lastScreen() {
    final lastScreen = all.screens.last;
    select(lastScreen);
  }

  SchemaStore nextScreen() {
    log('Move to next screen');
    return select(_screenByIndex(1));
  }

  SchemaStore _previousScreen() {
    return select(_screenByIndex(-1));
  }

  SchemaStore select(screen) {
    _current.select(screen);
    return screen;
  }

  SchemaStore selectByName(String name) {
    final screen = all.screens.where((screen) => screen.name == name).first;
    _current.select(screen);
    return screen;
  }

  SchemaStore selectById(UniqueKey id) {
    final screen = all.screens.where((screen) => screen.id == id).first;
    _current.select(screen);
    return screen;
  }

  SchemaStore _screenByIndex(indexDiff) {
    final possibleNextScreen = all.screens[_currentIndex + indexDiff];

    if (possibleNextScreen != null) {
      _current.select(possibleNextScreen);
      return possibleNextScreen;
    } else {
      return current;
    }
  }

  int get _currentIndex => all.screens.indexOf(current);
  SchemaStore get current => _current.currentScreen;
}
