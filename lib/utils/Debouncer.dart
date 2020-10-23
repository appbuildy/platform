import 'dart:async';

import 'package:flutter/foundation.dart';

class Debouncer<T> {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;
  T prevValue;

  void stopTimer() => _timer.cancel();
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
