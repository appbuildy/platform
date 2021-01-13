import 'package:flutter_app/app_skeleton/data_layer/i_data_element_key.dart';

class DetailedInfoKey implements IDataElementKey {
  String loadedPropertyName;
  String propertyClass;
  String rowDataKey;

  DetailedInfoKey(
      {String this.loadedPropertyName,
      String this.rowDataKey,
      String this.propertyClass});
}
