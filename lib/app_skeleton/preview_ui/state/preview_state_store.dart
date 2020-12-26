import 'package:flutter/foundation.dart';
import 'package:flutter_app/app_skeleton/entities/skeleton_project.dart';
import 'package:flutter_app/app_skeleton/entities/skeleton_screen.dart';
import 'package:flutter_app/utils/RandomKey.dart';
import 'package:mobx/mobx.dart';

part 'preview_state_store.g.dart';

/// if not set, initial screen sets to first one in the project screens list
class PreviewStateStore = _PreviewStateStore with _$PreviewStateStore;

abstract class _PreviewStateStore with Store {
  final SkeletonProject project;
  
  RandomKey initialKey;
  SkeletonScreen get initialScreen => project.screens[initialKey];
  @observable
  RandomKey currentScreenKey;
  @computed
  SkeletonScreen get currentScreen => project.screens[currentScreenKey];

  _PreviewStateStore({
    RandomKey initialScreenKey,
    @required this.project,
  }) {
    if (initialScreenKey == null ||
        project.screens.containsKey(initialScreenKey)) {
      currentScreenKey = project.screens?.keys?.first;
    } else {
      currentScreenKey = initialScreenKey;
    }
    initialKey = currentScreenKey;
  }

  @action
  void setCurrentScreen({RandomKey newScreenKey, SkeletonScreen newScreen}) {
    if (newScreenKey != null)
      currentScreenKey = newScreenKey;
    else if (newScreen != null && project.screens.containsKey(newScreen.id)) {
      currentScreenKey = newScreen.id;
    } else {
      print("Preview state store: couldn't find provided screen in the store");
    }
  }

  /// sets current key to the root(inital key)
  @action
  void setInitialKey() => setCurrentScreen(newScreenKey: initialKey);
}
