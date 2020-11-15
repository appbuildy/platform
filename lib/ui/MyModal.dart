import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/ui/Cursor.dart';

class MyModal {
  OverlayEntry _overlayEntry;
  Function onClose;

  void close() {
    if (this._overlayEntry != null) {
      this._overlayEntry.remove();
      this._overlayEntry = null;
    }

    if (this.onClose != null) {
      this.onClose();
    }
  }

  Widget _buildCloseButton() {
    final Widget closeButtonLine = (Container(
      width: 2,
      height: 15,
      decoration: BoxDecoration(
        color: Color(0xff6b7a8a),
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
    ));

    final Widget closeButton = (GestureDetector(
      onTap: this.close,
      child: Cursor(
        cursor: CursorEnum.pointer,
        child: Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            color: Colors.white,
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
                angle: 45 * pi / 180,
                child: closeButtonLine,
              ),
              Transform.rotate(
                angle: -45 * pi / 180,
                child: closeButtonLine,
              ),
            ],
          ),
        ),
      ),
    ));

    return closeButton;
  }

  Widget _buildModal(Widget child, double width, double height) {
    final Widget content = GestureDetector(
      onTap: () {},
      child: Stack(overflow: Overflow.visible, children: [
        Container(
          width: width ?? 800,
          height: height ?? double.infinity,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
          ),
          child: SingleChildScrollView(child: Container(child: child)),
        ),
        Positioned(
          top: -10,
          right: -10,
          child: this._buildCloseButton(),
        ),
      ]),
    );

    return GestureDetector(
      onTap: this.close,
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(61, 62, 75, 0.4)),
          alignment: AlignmentDirectional.center,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: headerHeight),
            child: content,
          ),
        ),
      ),
    );
  }

  void show({
    @required BuildContext context,
    @required Widget child,
    @required Function onClose,
    double width,
    double height,
  }) {
    if (this._overlayEntry != null) this.close();

    this._overlayEntry = OverlayEntry(
      builder: (BuildContext context) => this._buildModal(child, width, height)
    );
    this.onClose = onClose;

    Overlay.of(context).insert(this._overlayEntry);
  }
}
