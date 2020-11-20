import 'package:flutter/material.dart';

class InheretedApplicationWidget extends InheritedWidget {
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
