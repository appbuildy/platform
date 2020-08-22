import 'dart:async';

import 'package:flutter/foundation.dart';

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;
  dynamic prevValue;

  Debouncer({this.milliseconds, this.prevValue});

  run(VoidCallback action, dynamic updatedPrevValue) {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), () {
      action();
      prevValue = updatedPrevValue;
    });
  }
}
