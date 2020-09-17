import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/features/airtable/RemoteAttribute.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';

class RemoteAttributesSelect extends StatelessWidget {
  final UserActions userActions;
  const RemoteAttributesSelect({Key key, this.userActions}) : super(key: key);

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
        onChanged: (IRemoteAttribute newValue) {
          print('42');
        },
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
