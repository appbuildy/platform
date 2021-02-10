import 'package:flutter_app/app_skeleton/data_layer/i_data_element_key.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';

abstract class IElementData {
  SchemaNodeProperty getFor(IDataElementKey key);
}
