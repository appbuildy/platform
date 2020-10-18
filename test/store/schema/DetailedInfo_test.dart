import 'package:flutter/material.dart';
import 'package:flutter_app/store/schema/DetailedInfo.dart';
import 'package:flutter_app/utils/RandomKey.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('.toJson() serialization', () {
    final detailedInfo =
        DetailedInfo(rowData: {}, tableName: 'Table', screenId: RandomKey());

    expect(detailedInfo.toJson()['tableName'], equals(detailedInfo.tableName));
  });
}
