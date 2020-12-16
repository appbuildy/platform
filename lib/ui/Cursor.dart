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

class Cursor extends StatelessWidget {
  static final appContainer =
      html.window.document.querySelectorAll('flt-glass-pane')[0];

  final CursorEnum cursor;
  final Widget child;

  static Size constraintsOfObjectWhatShowingCursor;

  Cursor({
    @required this.cursor,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // todo: refac if possible.
    return MouseRegion(
        onHover: (PointerHoverEvent evt) {
          if (Cursor.constraintsOfObjectWhatShowingCursor != null) {

            if (
            Cursor.constraintsOfObjectWhatShowingCursor.width <= context.size.width
            && Cursor.constraintsOfObjectWhatShowingCursor.height <= context.size.height
            ) {
              return;
            }

          }
          else {
            Cursor.constraintsOfObjectWhatShowingCursor = context.size;
          }

          appContainer.style.cursor = CursorMap[cursor];
        },
        onExit: (PointerExitEvent evt) {
          appContainer.style.cursor = CursorMap[CursorEnum.defaultCursor];
          Cursor.constraintsOfObjectWhatShowingCursor = null;
        },
        child: child,
    );
  }
}
