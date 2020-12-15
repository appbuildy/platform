part of 'shared_widgets.dart';

/// convert string value to image fit
BoxFit _boxfitFromString(String fit) {
  switch (fit) {
    case 'Cover':
      return BoxFit.cover;
    case 'Fill':
      return BoxFit.fill;
    case 'None':
      return BoxFit.none;
    case 'Contain':
    default:
      return BoxFit.contain;
  }
}

class SharedImage extends StatelessWidget {
  const SharedImage({Key key, this.theme, this.size, this.properties})
      : super(key: key);

  final Map<String, SchemaNodeProperty> properties;
  final MyTheme theme;
  final Offset size;

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
        child: Image.network(
          properties['Url'].value,
          height: size.dx,
          width: size.dy,
          fit: _boxfitFromString(properties['Fit'].value),
        ),
      ),
    );
  }
}
