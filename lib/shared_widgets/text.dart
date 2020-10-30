import 'package:flutter/cupertino.dart' as Cupertino;
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_app/utils/getThemeColor.dart';

class Text extends StatelessWidget {
  const Text({Key key, this.theme, this.size, this.properties})
      : super(key: key);

  final Map<String, SchemaNodeProperty> properties;
  final Offset size;
  final MyTheme theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.dx,
      height: size.dy,
      child: Column(
        mainAxisAlignment: properties['MainAlignment'].value,
        crossAxisAlignment: properties['CrossAlignment'].value,
        children: [
          Padding(
            padding: EdgeInsets.all(2.0),
            child: Cupertino.Text(
              properties['Text'].value,
              style: TextStyle(
                  fontSize: properties['FontSize'].value,
                  fontWeight: properties['FontWeight'].value,
                  color: getThemeColor(theme, properties['FontColor'])),
            ),
          ),
        ],
      ),
    );
  }
}
