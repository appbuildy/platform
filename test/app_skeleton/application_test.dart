import 'package:flutter_app/app_skeleton/loading/application_loaded_from_json.dart';
import 'package:flutter_app/features/entities/Project.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeProject extends Project {
  Map<String, dynamic> data;
  FakeProject(this.data) : super('123');
}

void main() {
  final Map<String, dynamic> jsonApp = {
    "theme": {
      "name": "Blue",
      "general": {
        "red": 17,
        "blue": 17,
        "name": "general",
        "green": 17,
        "opacity": 1
      },
      "primary": {
        "red": 0,
        "blue": 255,
        "name": "primary",
        "green": 122,
        "opacity": 1
      },
      "secondary": {
        "red": 210,
        "blue": 255,
        "name": "secondary",
        "green": 231,
        "opacity": 1
      },
      "background": {
        "red": 255,
        "blue": 255,
        "name": "background",
        "green": 255,
        "opacity": 1
      },
      "separators": {
        "red": 194,
        "blue": 198,
        "name": "separators",
        "green": 194,
        "opacity": 1
      },
      "general_inverted": {
        "red": 249,
        "blue": 249,
        "name": "general_inverted",
        "green": 249,
        "opacity": 1
      },
      "general_secondary": {
        "red": 17,
        "blue": 17,
        "name": "general",
        "green": 17,
        "opacity": 1
      }
    },
    "screens": [
      {
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
            "position": {"x": 16, "y": 239.4140625},
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
        "detailedInfo": null,
        "backgroundColor": {
          "red": 255,
          "blue": 255,
          "name": "background",
          "green": 255,
          "opacity": 1
        },
        "bottomTabsVisible": true
      },
      {
        "id": {"value": "gPIEcFjss4OzKNWaJVtpTO7IbQaJ30"},
        "name": "Page 2",
        "components": [
          {
            "size": {"x": 335, "y": 50},
            "type": "SchemaNodeType.button",
            "actions": {
              "Tap": {
                "type": "SchemaActionType.goToScreen",
                "value": null,
                "action": "Tap",
                "propertyClass": "GoToScreenAction"
              }
            },
            "position": {"x": 20, "y": 133.75089375841182},
            "properties": {
              "Text": {
                "name": "Text",
                "value": "Screen 2",
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
        "detailedInfo": null,
        "backgroundColor": {
          "red": 255,
          "blue": 255,
          "name": "background",
          "green": 255,
          "opacity": 1
        },
        "bottomTabsVisible": true
      }
    ],
    "bottomNavigation": {
      "tabs": [
        {
          "id": {"value": "fqIWBC7nhzVwEctlWOqcvPwhx00Tp6"},
          "icon": {
            "codePoint": 61461,
            "fontFamily": "FontAwesomeSolid",
            "fontPackage": "font_awesome_flutter",
            "matchTextDirection": false
          },
          "label": "Home",
          "target": {"value": "9CQUD8pK1zNv0wNgzZvQrQUuXBhniV"}
        },
        {
          "id": {"value": "2sL6GCC9ry152fq2LTg1XtzjGUylyA"},
          "icon": {
            "codePoint": 61683,
            "fontFamily": "FontAwesomeRegular",
            "fontPackage": "font_awesome_flutter",
            "matchTextDirection": false
          },
          "label": "Page 2",
          "target": {"value": "gPIEcFjss4OzKNWaJVtpTO7IbQaJ30"}
        }
      ]
    }
  };
  final loadedApp =
      ApplicationLoadedFromJson(FakeProject({"canvas": jsonApp})).load();

  testWidgets('it changes screen with bottom navigation',
      (WidgetTester tester) async {
    await tester.pumpWidget(loadedApp);
    final textFinder = find.text('Button');
    expect(textFinder, findsOneWidget);
    await tester.tap(find.text('Page 2'));
    await tester.pump();
    expect(find.text('Screen 2'), findsOneWidget);
  });
}
