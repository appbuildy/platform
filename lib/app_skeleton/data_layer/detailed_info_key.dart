import 'package:flutter_app/app_skeleton/data_layer/i_data_element_key.dart';
import 'package:flutter_app/serialization/component_properties.dart';

class DetailedInfoKey implements IDataElementKey {
  String loadedPropertyName;
  String propertyClass;
  String rowDataKey;

  factory DetailedInfoKey.forComponentProperties(
      ComponentProperties componentProperties) {
    return DetailedInfoKey(
        propertyClass: "SchemaStringProperty",
        loadedPropertyName: componentProperties.propertyName,
        rowDataKey: componentProperties.properties['Column']?.value);
  }

  DetailedInfoKey(
      {String this.loadedPropertyName,
      String this.rowDataKey,
      String this.propertyClass});
}
