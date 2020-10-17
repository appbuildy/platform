import 'package:flutter_app/store/schema/ScreensStore.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/AppThemeStore.dart';

class SchemaConverter {
  ScreensStore screens;
  AppThemeStore appThemeStore;
  SchemaConverter(this.screens);

  Map<String, dynamic> toJson() => {
        'canvas': {
          'screens': screens.screens.map((screen) {
            return screen.toJson();
          }).toList()
        }
      };
}
