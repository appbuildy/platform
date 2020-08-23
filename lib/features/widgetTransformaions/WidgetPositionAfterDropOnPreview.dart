import 'package:flutter/material.dart';

class WidgetPositionAfterDropOnPreview {
  BuildContext _context;
  DragTargetDetails _widget;

  WidgetPositionAfterDropOnPreview(
      BuildContext context, DragTargetDetails widget) {
    _context = context;
    _widget = widget;
  }

  Offset calculate(double maxX, double maxY, Offset size) {
    RenderBox box = _context.findRenderObject();
    Offset position = box.localToGlobal(Offset.zero);
    double x = position.dx;
    double y = position.dy;

    double calculatedX = _widget.offset.dx - x;
    double calculatedY = _widget.offset.dy - y;

    if (calculatedX <= 0) {
      calculatedX = 0.0;
    } else if (calculatedX + size.dx > maxX) {
      calculatedX = maxX - size.dx;
    }

    if (calculatedY <= 0) {
      calculatedY = 0.0;
    } else if (calculatedY + size.dy > maxY) {
      calculatedY = maxY - size.dy;
    }

    return Offset(calculatedX, calculatedY);
  }
}
