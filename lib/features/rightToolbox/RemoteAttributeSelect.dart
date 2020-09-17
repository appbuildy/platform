import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/features/airtable/RemoteAttribute.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';

class RemoteAttributesSelect extends StatelessWidget {
  final UserActions userActions;
  final SchemaNodeProperty property;
  const RemoteAttributesSelect({Key key, this.userActions, this.property})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<IRemoteAttribute>(
        value: userActions.remoteAttributeList().first,
        icon: Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (IRemoteAttribute newValue) {},
        items: userActions
            .remoteAttributeList()
            .map<DropdownMenuItem<IRemoteAttribute>>((IRemoteAttribute value) {
          return DropdownMenuItem<IRemoteAttribute>(
            value: value,
            child: Text(value.name()),
          );
        }).toList());
  }
}
