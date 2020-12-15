part of 'shared_widgets.dart';

class SharedShape extends StatelessWidget {
  const SharedShape({Key key, this.theme, this.size, this.properties})
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
          color: getThemeColor(
            theme,
            properties['Color'],
          ),
          borderRadius:
              BorderRadius.circular(properties['BorderRadiusValue'].value)),
    );
  }
}
