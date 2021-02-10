import 'package:flutter_app/features/airtable/IRemoteTable.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListItem.dart';

import 'SchemaListItemsProperty.dart';

const listColumnsSample = [
  'house_price',
  'house_address',
  'house_image',
  'house_description',
];

class SchemaStringListProperty
    extends SchemaNodeProperty<Map<String, SchemaListItemsProperty>> {
  static Future<SchemaStringListProperty> fromRemoteTable(
      IRemoteTable remoteTable) async {
    final records = await remoteTable.records();
    final schemaStringListProperty = SchemaStringListProperty(
        'Items', Map<String, SchemaListItemsProperty>());

    records['records'].forEach((record) {
      final mapProps = Map<String, ListItem>();
      record['fields'].forEach((key, value) {
        mapProps[key] = ListItem(column: key, data: record['fields'][key]);
      });
      schemaStringListProperty.value[record['id']] =
          SchemaListItemsProperty(record['id'], mapProps);
    });

    return schemaStringListProperty;
  }

  factory SchemaStringListProperty.sample() {
    return SchemaStringListProperty('Items', {
      // пример дата айтемов-row с сгенеренными
      'house_first': SchemaListItemsProperty('house_first', {
        listColumnsSample[0]: ListItem(
            column: listColumnsSample[0], data: '\$539,990 | 3 Bedroom'),
        listColumnsSample[1]: ListItem(
          column: listColumnsSample[1],
          data: '885-891 3rd Ave, San Carlos, CA 94066',
        ),
        listColumnsSample[2]: ListItem(
          column: listColumnsSample[2],
          data:
              'https://images.unsplash.com/photo-1570129477492-45c003edd2be?ixlib=rb-1.2.1&auto=format&fit=crop&w=1280&q=80',
        ),
        listColumnsSample[3]: ListItem(
            column: listColumnsSample[3],
            data:
                "Incredible San Carlos 3-bedroom, 2-bathroom ranch style home located in the coveted Beverly Terrace neighborhood with amazing views of Brittan Canyon and the San Carlos hillside on an oversized 0.23 acre lot.  Featuring a completely remodeled kitchen with quartz counter tops, designer cabinetry, glass tile backsplash and stainless steel appliances. Remodeled bathrooms include elevated sinks, bright white makeup lights, expansive mirrors and tile flooring.  Upgraded double pane windows throughout the entire home and 5 "),
      }),
      'house_second': SchemaListItemsProperty('house_second', {
        listColumnsSample[0]: ListItem(
            column: listColumnsSample[0], data: '\$974,000 | 5 Bedroom'),
        listColumnsSample[1]: ListItem(
            column: listColumnsSample[1],
            data: '3939 4rd Ave, San Mateo, CA 94403'),
        listColumnsSample[2]: ListItem(
          column: listColumnsSample[2],
          data:
              'https://images.unsplash.com/photo-1591474200742-8e512e6f98f8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1280&q=80',
        ),
        listColumnsSample[3]: ListItem(
            column: listColumnsSample[3],
            data:
                "Welcome to 3939 4rd Ave, San Mateo, CA 94403, a private and incredibly special mid-century modern Eichler gem. Located in the heart of desirable Palo Verde this fully remodeled home's open floor plan and abundance of soothing natural light gives rise to a wonderful flow. All new appliances, countertops and flooring have been added throughout this gorgeous home to add a modern touch, enhancing the traditional intention of this space. The living room bathes in light and frames the serene and private, full wrap around yard, perfect for al-fresco di"),
      }),
      'house_third': SchemaListItemsProperty('house_third', {
        listColumnsSample[0]: ListItem(
            column: listColumnsSample[0], data: '\$840,900 | 4 Bedroom'),
        listColumnsSample[1]: ListItem(
            column: listColumnsSample[1],
            data: '2730 Summit Dr, Palo Alto, CA 94010'),
        listColumnsSample[2]: ListItem(
          column: listColumnsSample[2],
          data:
              'https://images.unsplash.com/photo-1582268611958-ebfd161ef9cf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1280&q=80',
        ),
        listColumnsSample[3]: ListItem(
            column: listColumnsSample[3],
            data:
                "Unbeatable Palo Alto views and in the acclaimed Woodside School District, this extensively remodeled two-story 4 BR, 3.5 BA home was designed for indoor/outdoor living.  Features a 2-car attached garage, a recently added solar-fed pool/spa complex and cabana, a large rear lawn/playing field, a pergola-covered outdoor dining area, a detached sauna and a 200-vine Bordeaux-blend vineyard, this property feels like you are living in your own private retreat.  Its inviting Spanish Mission revival architecture is complemented by recently upgraded "),
      }),
    });
  }

  SchemaStringListProperty(
      String name, Map<String, SchemaListItemsProperty> value)
      : super(name, value);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> outValue = {};

    this.value.forEach((key, val) {
      outValue['$key'] = val.toJson();
    });

    return {
      'propertyClass': 'SchemaStringListProperty',
      'name': this.name,
      'value': outValue,
    };
  }

  SchemaStringListProperty.fromJson(Map<String, dynamic> targetJson)
      : super('String List Property', null) {
    this.name = targetJson['name'];

    Map<String, SchemaListItemsProperty> innerValue = {};

    targetJson['value'].forEach((key, schemaListItemsTargetJson) {
      innerValue['$key'] =
          SchemaListItemsProperty.fromJson(schemaListItemsTargetJson);
    });

    this.value = innerValue;
  }

  @override
  SchemaStringListProperty copy() {
    return SchemaStringListProperty(this.name, this.value);
  }
}
