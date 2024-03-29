import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_app/ui/OpacityButton.dart';
import 'package:flutter_app/utils/getThemeColor.dart';

void emptyFunction() {}

class Button extends StatelessWidget {
  const Button(
      {Key key,
      this.theme,
      this.size,
      this.properties,
      this.isOpacityEnabled = true,
      this.onTap})
      : super(key: key);

  final Map<String, SchemaNodeProperty> properties;
  final Offset size;
  final Function onTap;
  final MyTheme theme;
  final bool isOpacityEnabled;

  @override
  Widget build(BuildContext context) {
    var opacity = properties['Opacity']?.value ?? 1.0;
    var fontOpacity = properties['fontOpacity']?.value ?? 1.0;

    return OpacityButton(
      enabled: isOpacityEnabled,
      onTap: onTap,
      child: Opacity(
        opacity: opacity,
        child: Container(
          width: size.dx,
          height: size.dy,
          decoration: BoxDecoration(
              color: getThemeColor(theme, properties['BackgroundColor']),
              boxShadow: properties['BoxShadow'].value
                  ? [
                      BoxShadow(
                          color:
                              getThemeColor(theme, properties['BoxShadowColor'])
                                  .withOpacity(
                                      properties['BoxShadowOpacity'].value),
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
                opacity: fontOpacity,
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
      ),
    );
  }
}
