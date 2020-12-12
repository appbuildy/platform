import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_app/utils/getThemeColor.dart';

class Button extends StatelessWidget {
  const Button({Key key, this.theme, this.size, this.properties})
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
            color: getThemeColor(theme, properties['BackgroundColor']),
            boxShadow: properties['BoxShadow'].value
                ? [
                    BoxShadow(
                        color: getThemeColor(
                                theme, properties['BoxShadowColor'])
                            .withOpacity(properties['BoxShadowOpacity'].value),
                        blurRadius: properties['BoxShadowBlur'].value,
                        offset: Offset(0.0, 2.0),
                        spreadRadius: 0)
                  ]
                : [],
            borderRadius: BorderRadius.circular(
                properties['BorderRadiusValue'].value.toDouble()),
            border: properties['Border'].value
                ? Border.all(
                    width: properties['BorderWidth'].value,
                    color: getThemeColor(theme, properties['BorderColor']))
                : null),
        child: Column(
          mainAxisAlignment: properties['MainAlignment'].value,
          crossAxisAlignment: properties['CrossAlignment'].value,
          children: [
            Opacity(
              opacity: properties['FontOpacity'].value,
              child: Text(
                properties['Text'].value,
                style: TextStyle(
                    fontWeight: properties['FontWeight'].value,
                    fontSize: properties['FontSize'].value.toDouble(),
                    color: getThemeColor(theme, properties['FontColor'])),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
