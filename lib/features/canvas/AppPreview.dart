import 'dart:developer';

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

  @override
  Widget build(BuildContext context) {
    return DragTarget<SchemaNode>(
      onAcceptWithDetails: (details) {
        RenderBox box = context.findRenderObject();
        Offset position =
            box.localToGlobal(Offset.zero); //this is global position
        double x = position.dx;
        double y = position.dy;

        details.data.position =
            Offset(details.offset.dx - x, details.offset.dy - y);

        schemaStore.add(details.data);
      },
      builder: (context, candidateData, rejectedData) {
        return (Container(
          color: Colors.black12,
          width: 375,
          height: 750,
          child: Observer(
            builder: (context) {
              log('i rerendered');
              return Stack(
                children: [
                  ...schemaStore.components.map((node) => Positioned(
                      child: GestureDetector(
                          onPanUpdate: (details) {
                            node.position = Offset(
                              node.position.dx + details.delta.dx,
                              node.position.dy + details.delta.dy,
                            );
                            schemaStore.update(node);
                          },
                          child: node.toWidget()),
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
