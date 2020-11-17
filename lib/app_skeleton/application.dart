import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/app_skeleton/screen.dart';
import 'package:flutter_app/utils/RandomKey.dart';

class Application extends StatefulWidget {
  final Map<RandomKey, Screen> screens;

  Application({Key key, this.screens}) : super(key: key);
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: widget.screens.values.first));
  }
}
