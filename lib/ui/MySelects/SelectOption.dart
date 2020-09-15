import 'package:flutter/material.dart';

class SelectOption {
  final String name;
  final dynamic value;
  final Widget leftWidget;

  SelectOption(this.name, this.value, [this.leftWidget]);
}
