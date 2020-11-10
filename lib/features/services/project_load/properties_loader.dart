import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';

class PropertiesLoader {
  Map<String, dynamic> jsonComponent;

  PropertiesLoader(this.jsonComponent);

  Map<String, SchemaNodeProperty> load() {
    final Map<String, SchemaNodeProperty> deserialized = {};
    jsonComponent['properties'].forEach((key, val) {
      deserialized[key] = SchemaNodeProperty.deserializeFromJson(val);
    });
    return deserialized;
  }
}
