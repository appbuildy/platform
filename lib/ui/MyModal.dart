import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_app/ui/MyModalCloseButton.dart';

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

  Widget _buildModal(Widget child, double width, double height) {
    final Widget content = GestureDetector(
      onTap: () {},
      child: Stack(
        clipBehavior: Clip.none,
        children: [
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
            child: MyModalCloseButton(
              onPressed: onClose,
            ),
          ),
        ],
      ),
    );

    return GestureDetector(
      onTap: this.close,
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(61, 62, 75, 0.4)),
          alignment: AlignmentDirectional.center,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: kHeaderHeight),
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
        builder: (BuildContext context) =>
            this._buildModal(child, width, height));
    this.onClose = onClose;

    Overlay.of(context).insert(this._overlayEntry);
  }
}
