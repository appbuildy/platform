import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeSpawner.dart';

class PropertiesLoader {
  Map<String, dynamic> jsonComponent;

  PropertiesLoader(this.jsonComponent);

  Map<String, SchemaNodeProperty> load(SchemaNodeSpawner schemaNodeSpawner) {
    final Map<String, SchemaNodeProperty> deserialized = {};
    jsonComponent['properties'].forEach((key, val) {
      deserialized[key] = SchemaNodeProperty.deserializeFromJson(val, schemaNodeSpawner);
    });
    return deserialized;
  }
}
