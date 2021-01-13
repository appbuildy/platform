import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/store/schema/DetailedInfo.dart';

import 'i_element_data.dart';

class DataFromDetailedInfo implements IElementData {
  DetailedInfo detailedInfo;
  DataFromDetailedInfo(detailedInfo);

  @override
  SchemaNodeProperty getFor(Map<String, dynamic> key) {
    if (detailedInfo == null || key == null) return null;
  }
}
