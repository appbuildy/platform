import 'dart:convert';

import 'package:flutter_app/app_skeleton/loading/screen_load_from_json.dart';
import 'package:flutter_app/shared_widgets/widget_decorator.dart';
import 'package:flutter_app/store/schema/DetailedInfo.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Map<String, dynamic> jsonScreen = {
    "id": {"value": "9CQUD8pK1zNv0wNgzZvQrQUuXBhniV"},
    "name": "Home",
    "components": [
      {
        "size": {"x": 343, "y": 50},
        "type": "SchemaNodeType.button",
        "actions": {
          "Tap": {
            "type": "SchemaActionType.goToScreen",
            "value": {"value": "9CQUD8pK1zNv0wNgzZvQrQUuXBhniV"},
            "action": "Tap",
            "propertyClass": "GoToScreenAction"
          }
        },
        "position": {"x": 20, "y": 270.0546875},
        "properties": {
          "Text": {
            "name": "Text",
            "value": "Button",
            "propertyClass": "SchemaStringProperty"
          },
          "Border": {
            "name": "Border",
            "value": false,
            "propertyClass": "SchemaBoolProperty"
          },
          "FontSize": {
            "name": "FontSize",
            "value": 16,
            "propertyClass": "SchemaIntProperty"
          },
          "BoxShadow": {
            "name": "BoxShadow",
            "value": false,
            "propertyClass": "SchemaBoolProperty"
          },
          "FontColor": {
            "name": "FontColor",
            "value": {"name": "general_inverted", "color": 4294572537},
            "propertyClass": "SchemaMyThemePropProperty"
          },
          "FontWeight": {
            "name": "FontWeight",
            "value": 4,
            "propertyClass": "SchemaFontWeightProperty"
          },
          "BorderColor": {
            "name": "BorderColor",
            "value": {"name": "primary", "color": 4278221567},
            "propertyClass": "SchemaMyThemePropProperty"
          },
          "BorderWidth": {
            "name": "BorderWidth",
            "value": 1,
            "propertyClass": "SchemaIntProperty"
          },
          "BoxShadowBlur": {
            "name": "BoxShadowBlur",
            "value": 5,
            "propertyClass": "SchemaIntProperty"
          },
          "MainAlignment": {
            "name": "MainAlignment",
            "value": 2,
            "propertyClass": "SchemaMainAlignmentProperty"
          },
          "BoxShadowColor": {
            "name": "BoxShadowColor",
            "value": {"name": "general", "color": 4279308561},
            "propertyClass": "SchemaMyThemePropProperty"
          },
          "CrossAlignment": {
            "name": "CrossAlignment",
            "value": 2,
            "propertyClass": "SchemaCrossAlignmentProperty"
          },
          "BackgroundColor": {
            "name": "BackgroundColor",
            "value": {"name": "primary", "color": 4278221567},
            "propertyClass": "SchemaMyThemePropProperty"
          },
          "BoxShadowOpacity": {
            "name": "BoxShadowOpacity",
            "value": 0.5,
            "propertyClass": "SchemaDoubleProperty"
          },
          "BorderRadiusValue": {
            "name": "BorderRadiusValue",
            "value": 9,
            "propertyClass": "SchemaIntProperty"
          }
        }
      }
    ],
    "detailedInfo": {
      "rowData": {
        "house_image": {"data": "random", "column": "house_image"},
        "house_price": {"data": "539,990 | 3 Bedroom", "column": "house_price"},
        "house_address": {
          "data": "885-891 3rd Ave, San Carlos, CA 94066",
          "column": "house_address"
        },
        "house_description": {
          "data":
              "Incredible San Carlos 3-bedroom, 2-bathroom ranch style home located in the coveted Beverly Terrace neighborhood with amazing views of Brittan Canyon and the San Carlos hillside on an oversized 0.23 acre lot.  Featuring a completely remodeled kitchen with quartz counter tops, designer cabinetry, glass tile backsplash and stainless steel appliances. Remodeled bathrooms include elevated sinks, bright white makeup lights, expansive mirrors and tile flooring.  Upgraded double pane windows throughout the entire home and 5 ",
          "column": "house_description"
        }
      },
      "screenId": {"value": "yuqM5QYTBJYjIxCnQ42pzdEkntv7oN"},
      "tableName": null
    },
    "backgroundColor": {
      "red": 255,
      "blue": 255,
      "name": "background",
      "green": 255,
      "opacity": 1
    },
    "bottomTabsVisible": true
  };

  test('.load() loads screen and components', () {
    var loader = ScreenLoadFromJson(jsonScreen);
    var screen = loader.load();
    expect(screen.widgets.first, isA<WidgetDecorator>());
    expect(screen.detailedInfo, isA<DetailedInfo>());
  });
}
