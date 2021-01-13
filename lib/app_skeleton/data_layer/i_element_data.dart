import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';

abstract class IElementData {
  SchemaNodeProperty getFor(Map<String, dynamic> key);
}
