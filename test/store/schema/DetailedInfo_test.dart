import 'package:flutter_app/features/schemaNodes/lists/ListItem.dart';
import 'package:flutter_app/store/schema/DetailedInfo.dart';
import 'package:flutter_app/utils/RandomKey.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('.toJson() serialization', () {
    final rowDataMap = {'Test': ListItem(column: '322', data: 'kek')};
    final detailedInfo = DetailedInfo(
        rowData: rowDataMap, tableName: 'Table', screenId: RandomKey());

    expect(detailedInfo.toJson()['tableName'], equals(detailedInfo.tableName));

    final deserialized = DetailedInfo.fromJson(detailedInfo.toJson());
    expect(deserialized.tableName, equals(detailedInfo.tableName));
    expect(deserialized.rowData.values.first.data, equals('kek'));
  });
}
