import 'package:flutter_app/store/schema/BottomNavigationStore.dart';
import 'package:flutter_app/store/schema/ScreensStore.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';

class SchemaConverter {
  ScreensStore screens;
  MyTheme theme;
  BottomNavigationStore bottomNavigationStore;
  SchemaConverter({this.screens, this.theme, this.bottomNavigationStore});

  Map<String, dynamic> toJson() => {
        'canvas': {
          'bottomNavigation': bottomNavigationStore.toJson(),
          'theme': theme.toJson(),
          'screens': screens.screens.map((screen) {
            return screen.toJson();
          }).toList()
        }
      };
}
