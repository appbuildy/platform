import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/services/project_load/IComponentLoader.dart';

class ComponentLoadedFromJson implements IComponentLoader {
  Map<String, dynamic> jsonComponent;
  ComponentLoadedFromJson(this.jsonComponent);

  @override
  SchemaNode load() {
    throw UnimplementedError();
  }
}
