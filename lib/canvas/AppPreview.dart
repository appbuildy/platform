import 'package:flutter/material.dart';
import 'package:flutter_app/canvas/WidgetWrapper.dart';
import 'package:flutter_app/store/tree/ConstructorCanvas.dart';

class AppPreview extends StatefulWidget {
  final List<WidgetWrapper> components;

  const AppPreview({Key key, @required this.components}) : super(key: key);

  @override
  _AppPreviewState createState() => _AppPreviewState();
}

class _AppPreviewState extends State<AppPreview> {
  ConstructorCanvas canvas;

  @override
  void initState() {
    super.initState();
    canvas = ConstructorCanvas(components: widget.components);
  }

  @override
  Widget build(BuildContext context) {
    return (Container(
      color: Colors.black12,
      width: 375,
      height: 500,
      child: Stack(
        children: [
          ...canvas.components.map((component) => Positioned(
              child: Draggable(
                  data: 'Test',
                  childWhenDragging: component.flutterWidget,
                  feedback: component.flutterWidget,
                  child: component.flutterWidget),
              top: component.position.x.toDouble(),
              left: component.position.y.toDouble()))
        ],
      ),
    ));
  }
}
