import 'package:flutter/material.dart';

class InheritedApplicationWidget extends InheritedWidget {
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
