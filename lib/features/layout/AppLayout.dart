import 'package:flutter/material.dart';
import 'package:flutter_app/features/canvas/AppPreview.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/toolbox/Toolbox.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';

class AppLayout extends StatefulWidget {
  @override
  _AppLayoutState createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  SchemaStore schemaStore;
  UserActions userActions;

  @override
  void initState() {
    super.initState();
    schemaStore = SchemaStore(components: []);
    userActions = UserActions();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  child: Center(child: Toolbox()),
                  decoration: BoxDecoration(
                      color: Color(0xFFEAEAEA),
                      border: Border(
                          right: BorderSide(width: 1, color: Colors.black))),
                ),
              ),
              Flexible(
                flex: 2,
                child: Center(
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            MaterialButton(
                                onPressed: () {
                                  userActions.undo();
                                },
                                child: Text('Undo')),
                            MaterialButton(
                              onPressed: () {},
                              child: Text('Redo'),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        AppPreview(
                          schemaStore: schemaStore,
                          userActions: userActions,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFEAEAEA),
                      border: Border(
                          left: BorderSide(width: 1, color: Colors.black))),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
