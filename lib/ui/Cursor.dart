import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

enum CursorEnum {
  defaultCursor,
  pointer,
  move,
  neswResize,
  nwseResize,
  nsResize,
  ewResize
}

const CursorMap = {
  CursorEnum.defaultCursor: 'default',
  CursorEnum.pointer: 'pointer',
  CursorEnum.move: 'move',
  CursorEnum.neswResize: 'nesw-resize',
  CursorEnum.nwseResize: 'nwse-resize',
  CursorEnum.nsResize: 'ns-resize',
  CursorEnum.ewResize: 'ew-resize',
};

class Cursor extends MouseRegion {
  static final appContainer =
      html.window.document.querySelectorAll('flt-glass-pane')[0];
  Cursor({@required Widget child, @required CursorEnum cursor})
      : super(
            onHover: (PointerHoverEvent evt) {
              appContainer.style.cursor = CursorMap[cursor];
            },
            onExit: (PointerExitEvent evt) {
              appContainer.style.cursor = 'default';
            },
            child: child);
}
