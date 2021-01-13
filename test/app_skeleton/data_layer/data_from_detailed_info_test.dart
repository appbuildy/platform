import 'package:flutter_app/app_skeleton/data_layer/data_from_detailed_info.dart';
import 'package:flutter_app/store/schema/DetailedInfo.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var column = {
    "name": "Column",
    "value": "house_description",
    "propertyClass": "SchemaStringProperty"
  };
  var house_description = 'RANDOM';
  var detailedInfoJson = {
    "rowData": {
      "house_image": {"data": "random", "column": "house_image"},
      "house_price": {"data": "539,990 | 3 Bedroom", "column": "house_price"},
      "house_address": {
        "data": "885-891 3rd Ave, San Carlos, CA 94066",
        "column": "house_address"
      },
      "house_description": {
        "data": house_description,
        "column": "house_description"
      }
    },
    "screenId": {"value": "yuqM5QYTBJYjIxCnQ42pzdEkntv7oN"},
    "tableName": null
  };
  var detailedInfo = DetailedInfo.fromJson(detailedInfoJson);
  var dataSource = DataFromDetailedInfo(detailedInfo);

  test('getFor() gets data from detailed info', () {
    expect(dataSource.getFor(column).value, equals(house_description));
  });
}
