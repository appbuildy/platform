part of 'shared_widgets.dart';

class SharedButton extends StatelessWidget {
  final Map<String, SchemaNodeProperty> properties;
  final MyTheme theme;

  const SharedButton({
    Key key,
    this.theme,
    this.properties,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: getThemeColor(theme, properties['BackgroundColor']),
        boxShadow: properties['BoxShadow'].value
            ? [
                BoxShadow(
                  color: getThemeColor(theme, properties['BoxShadowColor'])
                      .withOpacity(properties['BoxShadowOpacity'].value),
                  blurRadius: properties['BoxShadowBlur'].value,
                  offset: Offset(0.0, 2.0),
                  spreadRadius: 0,
                )
              ]
            : [],
        borderRadius: BorderRadius.circular(
          properties['BorderRadiusValue'].value.toDouble(),
        ),
        border: properties['Border'].value
            ? Border.all(
                width: properties['BorderWidth'].value,
                color: getThemeColor(
                  theme,
                  properties['BorderColor'],
                ),
              )
            : null,
      ),
      child: Column(
        mainAxisAlignment: properties['MainAlignment'].value,
        crossAxisAlignment: properties['CrossAlignment'].value,
        children: [
          Text(
            properties['Text'].value,
            style: TextStyle(
              fontWeight: properties['FontWeight'].value,
              fontSize: properties['FontSize'].value.toDouble(),
              color: getThemeColor(theme, properties['FontColor']),
            ),
          ),
        ],
      ),
    );
  }
}
