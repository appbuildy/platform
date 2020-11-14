import 'package:flutter/src/widgets/framework.dart';

import 'i_widget_load.dart';

class WidgetFromJson implements IWidgetLoad {
  final Map<String, dynamic> jsonComponent;

  WidgetFromJson(this.jsonComponent);

  @override
  Widget load() {}

  _loadProperties() {}
  _loadSize() {}
}
