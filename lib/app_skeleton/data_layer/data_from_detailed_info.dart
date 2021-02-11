import 'package:flutter_app/app_skeleton/data_layer/detailed_info_key.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/store/schema/DetailedInfo.dart';

import 'i_data_element_key.dart';
import 'i_element_data.dart';

class DataFromDetailedInfo implements IElementData {
  DetailedInfo detailedInfo;
  DataFromDetailedInfo(this.detailedInfo);

  String getString(String key) {
    return detailedInfo.rowData[key].data;
  }

  @override
  SchemaNodeProperty getFor(IDataElementKey key) {
    if (detailedInfo == null || key == null) return null;
    var localKey = (key as DetailedInfoKey);

    return SchemaNodeProperty.deserializeFromJson({
      "propertyClass": localKey.propertyClass,
      "name": localKey.loadedPropertyName,
      "value": detailedInfo.rowData[localKey.rowDataKey].data
    });
  }
}
