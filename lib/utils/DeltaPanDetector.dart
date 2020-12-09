import 'package:flutter/material.dart';

class PositionChanged {
  double dx = 0;
  double dy = 0;

  PositionChanged({
    this.dx = 0,
    this.dy = 0,
  });
}

typedef PositionChangedCallback = PositionChanged Function(Offset);

class DeltaFromAnchorPointPanDetector extends StatefulWidget {
  final PositionChangedCallback onPanUpdate;
  final Function onPanEnd;
  final Widget child;
  final bool canMove;

  static positionChanged({dx = 0, dy = 0}) => PositionChanged(dx: dx, dy: dy);

  DeltaFromAnchorPointPanDetector({
    @required this.onPanUpdate,
    @required this.child,
    @required this.onPanEnd,
    this.canMove = true,
  });

  @override
  _DeltaFromAnchorPointPanDetectorState createState() => _DeltaFromAnchorPointPanDetectorState();
}

class _DeltaFromAnchorPointPanDetectorState extends State<DeltaFromAnchorPointPanDetector> {
  double _deltaDx = 0;
  double _deltaDy = 0;

  void addDeltaDx(double num) => _deltaDx += num;
  void addDeltaDy(double num) => _deltaDy += num;

  void correctDeltaDx(double num) => addDeltaDx(num);
  void correctDeltaDy(double num) => addDeltaDy(num);

  void clearDeltaDx() => _deltaDx = 0;
  void clearDeltaDy() => _deltaDy = 0;

  void onPanUpdate(details) {
    if (widget.canMove) {
      this.addDeltaDx(details.delta.dx);
      this.addDeltaDy(details.delta.dy);

      PositionChanged positionChanged = widget.onPanUpdate(Offset(this._deltaDx, this._deltaDy));

      if (positionChanged.dx != 0) {
        positionChanged.dx == _deltaDx ? this.clearDeltaDx() : this.correctDeltaDx(positionChanged.dx);
      }

      if (positionChanged.dy != 0) {
        positionChanged.dy == _deltaDy ? this.clearDeltaDy() : this.correctDeltaDy(positionChanged.dy);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: this.onPanUpdate,
      onPanEnd: (_) {
        this.clearDeltaDx();
        this.clearDeltaDy();
        this.widget.onPanEnd(_);
      },
      child: widget.child,
    );
  }
}