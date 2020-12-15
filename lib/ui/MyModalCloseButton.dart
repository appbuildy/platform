import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:flutter_app/ui/Cursor.dart';

const Widget _closeButtonLine = DecoratedBox(
  decoration: BoxDecoration(
    color: Color(0xff6b7a8a),
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
  child: SizedBox(
    width: 2,
    height: 15,
  ),
);

class MyModalCloseButton extends StatelessWidget {
  final VoidCallback onPressed;
  const MyModalCloseButton({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Cursor(
      cursor: CursorEnum.pointer,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.4),
                spreadRadius: 0,
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Transform.rotate(
                angle: 45 * math.pi / 180,
                child: _closeButtonLine,
              ),
              Transform.rotate(
                angle: -45 * math.pi / 180,
                child: _closeButtonLine,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
