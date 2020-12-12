import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_app/utils/getThemeColor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Icon extends StatelessWidget {
  const Icon({Key key, this.theme, this.size, this.properties})
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
            borderRadius:
                BorderRadius.circular(properties['BorderRadiusValue'].value)),
        child: ClipRRect(
          borderRadius:
              BorderRadius.circular(properties['BorderRadiusValue'].value),
          child: FaIcon(
            properties['Icon'].value,
            size: properties['IconSize'].value,
            color: getThemeColor(theme, properties['IconColor']),
          ),
        ),
      ),
    );
  }
}
