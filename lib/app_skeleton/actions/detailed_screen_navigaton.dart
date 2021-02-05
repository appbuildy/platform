import 'package:flutter/material.dart';
import 'package:flutter_app/app_skeleton/data_layer/data_from_detailed_info.dart';
import 'package:flutter_app/app_skeleton/data_layer/i_element_data.dart';
import 'package:flutter_app/app_skeleton/loading/screen_load_from_json.dart';
import 'package:flutter_app/features/entities/Project.dart';
import 'package:flutter_app/store/schema/DetailedInfo.dart';
import 'package:flutter_app/utils/RandomKey.dart';

import '../screen.dart';

class DetailedScreenNavigation {
  Screen targetScreen;
  IElementData elementDataForScreen;
  Project project;

  DetailedScreenNavigation(
      {@required targetScreen, @required valuesForScreen, @required project}) {
    this.targetScreen = targetScreen;
    this.project = project;
    this.elementDataForScreen = DataFromDetailedInfo(DetailedInfo(
        screenId: RandomKey(), tableName: 'name', rowData: valuesForScreen));
  }

  void navigate(context) {
    var tempScreen = _loadTempScreen();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => tempScreen),
    );
  }

  Screen _loadTempScreen() {
    return ScreenLoadFromJson(targetScreen.serializedJson).load(
        bottomNavigation: targetScreen.bottomNavigation,
        project: project,
        elementData: elementDataForScreen);
  }
}
