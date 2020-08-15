import 'package:flutter_app/canvas/WidgetWrapper.dart';
import 'package:mobx/mobx.dart';

class ConstructorCanvas {
  ConstructorCanvas({List<WidgetWrapper> components}) {
    add = Action(_add);
  }

  final _components = Observable([]);
  List<WidgetWrapper> get components => _components.value;

  set components(List<WidgetWrapper> components) =>
      _components.value = components;

  Action add;
  void _add(WidgetWrapper widgetWrapper) {
    _components.value.add(widgetWrapper);
  }
}
