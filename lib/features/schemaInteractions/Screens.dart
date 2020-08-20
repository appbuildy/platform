import 'package:flutter_app/features/schemaInteractions/BaseAction.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_app/store/schema/ScreensStore.dart';
import 'package:flutter_app/store/userActions/AddScreen.dart';
import 'package:flutter_app/store/userActions/CurrentScreen.dart';

class Screens {
  CurrentScreen _current;
  ScreensStore all;
  Screens(this.all, this._current);

  BaseAction create({moveToNextAfterCreated = false}) {
    final action = AddScreen(screensStore: all);

    action.execute();
    return action;
  }

  SchemaStore nextScreen() {
    all.screens.indexOf(current);
    final possibleNextScreen = all.screens[_currentIndex + 1];

    if (possibleNextScreen != null) {
      _current.select(possibleNextScreen);
      return possibleNextScreen;
    } else {
      return current;
    }
  }

  SchemaStore previousScreen() {
    all.screens.indexOf(current);
  }

  void select(screen) {}

  int get _currentIndex => all.screens.indexOf(current);
  SchemaStore get current => _current.currentScreen;
}
