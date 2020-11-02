import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/shared_widgets/widget_decorator.dart';

class Application extends StatefulWidget {
  final List<WidgetDecorator> widgets = [];

  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: Center()));
  }
}
