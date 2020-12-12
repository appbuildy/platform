import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_app/utils/getThemeColor.dart';

class Shape extends StatelessWidget {
  const Shape({Key key, this.theme, this.size, this.properties})
      : super(key: key);

  final Map<String, SchemaNodeProperty> properties;
  final Offset size;
  final MyTheme theme;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: properties['Opacity'].value,
      child: Container(
        width: size.dx,
        height: size.dy,
        decoration: BoxDecoration(
            color: getThemeColor(
              theme,
              properties['Color'],
            ),
            borderRadius:
                BorderRadius.circular(properties['BorderRadiusValue'].value)),
      ),
    );
  }
}
