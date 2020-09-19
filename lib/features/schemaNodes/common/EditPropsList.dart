import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/utils/Debouncer.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsListItem.dart';

class EditPropsList extends StatelessWidget {
  final UniqueKey id;
  final Map<String, SchemaNodeProperty> properties;
  final String propName;
  final UserActions userActions;
  final Debouncer textDebouncer;

  const EditPropsList(
      {Key key,
      @required this.id,
      @required this.properties,
      @required this.propName,
      @required this.userActions,
      @required this.textDebouncer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(properties[propName].value);
    final children = properties[propName]
        .value
        .values
        .map((prop) {
          return EditPropsListItem(
              listKey: prop.name,
              id: id,
              properties: properties,
              propName: propName,
              userActions: userActions,
              textDebouncer:
                  textDebouncer); //TODO: create debouncer for each instance
        })
        .toList()
        .cast<Widget>();
    return Column(children: children);
  }
}
