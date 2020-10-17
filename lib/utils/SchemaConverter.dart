import 'package:flutter_app/store/schema/ScreensStore.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';

class SchemaConverter {
  ScreensStore screens;
  MyTheme theme;
  SchemaConverter(this.screens, this.theme);

  Map<String, dynamic> toJson() => {
        'theme': theme.toJson(),
        'canvas': {
          'screens': screens.screens.map((screen) {
            return screen.toJson();
          }).toList()
        }
      };
}
