import 'package:flutter/material.dart';
import 'package:flutter_app/features/canvas/SchemaNode.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AppPreview extends StatefulWidget {
  final List<SchemaNode> components;

  const AppPreview({Key key, @required this.components}) : super(key: key);

  @override
  _AppPreviewState createState() => _AppPreviewState();
}

class _AppPreviewState extends State<AppPreview> {
  SchemaStore schemaStore;
  int counter;

  @override
  void initState() {
    super.initState();
    schemaStore = SchemaStore(components: widget.components);
  }

  Widget _buildWidgetBySchemaNode(SchemaNodeType type) {
    switch (type) {
      case SchemaNodeType.button:
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1, color: Colors.tealAccent)),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text('Button'),
          ),
        );
      case SchemaNodeType.text:
        return Text('Text');
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<SchemaNodeType>(
      onAcceptWithDetails: (details) {
        RenderBox box = context.findRenderObject();
        Offset position =
            box.localToGlobal(Offset.zero); //this is global position
        double x = position.dx;
        double y = position.dy;

        schemaStore.add(SchemaNode(
            type: details.data,
            position: Offset(details.offset.dx - x, details.offset.dy - y)));
      },
      builder: (context, candidateData, rejectedData) {
        return (Container(
          color: Colors.black12,
          width: 375,
          height: 750,
          child: Observer(
            builder: (context) {
              return Stack(
                children: [
                  ...schemaStore.components.map((node) => Positioned(
                      child: Draggable(
                          data: 'Test',
                          childWhenDragging:
                              _buildWidgetBySchemaNode(node.type),
                          feedback: _buildWidgetBySchemaNode(node.type),
                          child: _buildWidgetBySchemaNode(node.type)),
                      top: node.position.dy,
                      left: node.position.dx))
                ],
              );
            },
          ),
        ));
      },
    );
  }
}
