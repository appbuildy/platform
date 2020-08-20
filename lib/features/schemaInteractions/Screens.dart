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
    return _screenByIndex(1);
  }

  SchemaStore previousScreen() {
    return _screenByIndex(-2);
  }

  void select(screen) {}

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
