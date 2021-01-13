import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaStringProperty.dart';
import 'package:flutter_app/store/schema/DetailedInfo.dart';

import 'i_element_data.dart';

class DataFromDetailedInfo implements IElementData {
  DetailedInfo detailedInfo;
  DataFromDetailedInfo(this.detailedInfo);

  @override
  SchemaNodeProperty getFor(Map<String, dynamic> key) {
    if (detailedInfo == null || key == null) return null;

    return SchemaNodeProperty.deserializeFromJson({
      "propertyClass": key['propertyClass'],
      "name": _nameFor(key),
      "value": detailedInfo.rowData[key['value']].data
    });
  }

  _nameFor(key) {
    return key['loadedPropertyName'] ?? 'Text';
  }
}
