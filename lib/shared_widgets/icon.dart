part of 'shared_widgets.dart';

class SharedIcon extends StatelessWidget {
  const SharedIcon({
    Key key,
    this.theme,
    this.properties,
  }) : super(key: key);

  final Map<String, SchemaNodeProperty> properties;
  final MyTheme theme;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            properties['BorderRadiusValue'].value,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            properties['BorderRadiusValue'].value,
          ),
          child: FaIcon(
            properties['Icon'].value,
            size: properties['IconSize'].value,
            color: getThemeColor(
              theme,
              properties['IconColor'],
            ),
          ),
        ));
  }
}
