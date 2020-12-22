import 'package:flutter/material.dart';
import 'package:flutter_app/features/layout/AppLayout.dart';
import 'package:flutter_app/features/schemaInteractions/SetupUserActions.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/ui/app_loader/app_loader.dart';

class ApplicationBuilderApp extends StatelessWidget {
  const ApplicationBuilderApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// initialize global state and return builder layout
    Future<Widget> buildLayout() async {
      final UserActions userActions = setupUserActions();
      await userActions.loadProject();
      return AppLayout(userActions: userActions);
    }

    return MaterialApp(
      title: 'AppBuildy — create your apps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
          body: AppLoader(
        asyncBuilder: buildLayout(),
      )),
    );
  }
}
