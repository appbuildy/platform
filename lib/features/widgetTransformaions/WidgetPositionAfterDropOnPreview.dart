import 'package:flutter/material.dart';

class WidgetPositionAfterDropOnPreview {
  BuildContext _context;
  DragTargetDetails _widget;

  WidgetPositionAfterDropOnPreview(
      BuildContext context, DragTargetDetails widget) {
    _context = context;
    _widget = widget;
  }

  Offset calculate() {
    RenderBox box = _context.findRenderObject();
    Offset position = box.localToGlobal(Offset.zero);
    double x = position.dx;
    double y = position.dy;

    return Offset(_widget.offset.dx - x, _widget.offset.dy - y);
  }
}
