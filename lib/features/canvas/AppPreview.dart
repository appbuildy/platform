import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/canvas/SchemaNode.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';

class AppPreview extends StatefulWidget {
  final List<SchemaNode> components;

  const AppPreview({Key key, @required this.components}) : super(key: key);

  @override
  _AppPreviewState createState() => _AppPreviewState();
}

class _AppPreviewState extends State<AppPreview> {
  SchemaStore canvas;

  @override
  void initState() {
    super.initState();
    canvas = SchemaStore(components: widget.components);
  }

  Widget _buildWidgetBySchemaNode(SchemaNodeType type) {
    switch (type) {
      case SchemaNodeType.button:
        return MaterialButton(
          onPressed: () {},
          child: Text('Button'),
        );
      case SchemaNodeType.text:
        return Text('Text');
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget(
      onAccept: (SchemaNodeType value) {
        log('value $value');
      },
      builder: (context, List<String> CandidateData, rejectedData) {
        return (Container(
          color: Colors.black12,
          width: 375,
          height: 500,
          child: Stack(
            children: [
              ...canvas.components.map((node) => Positioned(
                  child: Draggable(
                      data: 'Test',
                      childWhenDragging: _buildWidgetBySchemaNode(node.type),
                      feedback: _buildWidgetBySchemaNode(node.type),
                      child: _buildWidgetBySchemaNode(node.type)),
                  top: node.position.x.toDouble(),
                  left: node.position.y.toDouble()))
            ],
          ),
        ));
      },
    );
  }
}
