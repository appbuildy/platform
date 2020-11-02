import 'package:flutter/cupertino.dart' as Cupertino;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';

class Image extends StatelessWidget {
  BoxFit getFitOnString(String fit) {
    if (fit == 'Contain') {
      return BoxFit.contain;
    } else if (fit == 'Cover') {
      return BoxFit.cover;
    } else if (fit == 'Fill') {
      return BoxFit.fill;
    } else if (fit == 'None') {
      return BoxFit.none;
    }
  }

  const Image({Key key, this.theme, this.size, this.properties})
      : super(key: key);

  final Map<String, SchemaNodeProperty> properties;
  final Offset size;
  final MyTheme theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.dx,
      height: size.dy,
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(properties['BorderRadiusValue'].value)),
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(properties['BorderRadiusValue'].value),
        child: Cupertino.Image.network(
          properties['Url'].value,
          fit: getFitOnString(properties['Fit'].value),
        ),
      ),
    );
  }
}
