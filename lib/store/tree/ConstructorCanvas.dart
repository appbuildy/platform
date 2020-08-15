import 'package:flutter_app/canvas/WidgetWrapper.dart';
import 'package:mobx/mobx.dart';

part 'ConstructorCanvas.g.dart';

class ConstructorCanvas = _ConstructorCanvas with _$ConstructorCanvas;

abstract class _ConstructorCanvas with Store {
  _ConstructorCanvas({List<WidgetWrapper> components}) {
    this.components = components;
  }

  @observable
  List<WidgetWrapper> components = [];

  @action
  void add(WidgetWrapper widgetWrapper) {
    components.add(widgetWrapper);
  }
}
