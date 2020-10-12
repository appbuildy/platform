import 'package:flutter_app/store/schema/ScreensStore.dart';

class SchemaConverter {
  ScreensStore screens;
  SchemaConverter(this.screens);

  Map<String, dynamic> toJson() => {
        'canvas': {
          'screens': screens.screens.map((screen) {
            return screen.toJson();
          }).toList()
        }
      };
}
