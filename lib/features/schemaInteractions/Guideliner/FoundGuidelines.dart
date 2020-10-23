import 'package:flutter/material.dart';

import 'Guidelines.dart';

class FoundGuidelines {
  FoundGuideline _horizontalGuideLine;
  FoundGuideline _verticalGuideLine;

  void clearHorizontal() => this._horizontalGuideLine = null;

  void clearVertical() => this._verticalGuideLine = null;

  void clear() {
    this.clearHorizontal();
    this.clearVertical();
  }

  set setHorizontal(FoundGuideline guideline) => this._horizontalGuideLine = guideline;

  set seVertical(FoundGuideline guideline) => this._verticalGuideLine = guideline;

  List<Widget> toWidgets({ @required Offset screenSize }) {

    return [
      this._horizontalGuideLine?.guideline?.buildLine(screenSize: screenSize) ?? Container(),
      this._verticalGuideLine?.guideline?.buildLine(screenSize: screenSize) ?? Container(),
    ];
  }
}