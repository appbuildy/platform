import 'package:flutter/material.dart';
import 'package:flutter_app/features/layout/AppLayout.dart';

import 'features/canvas/AppPreview.dart';
import 'features/canvas/SchemaNode.dart';
import 'features/canvas/WidgetPosition.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int buttonX;
  int buttonY;
  AppPreview constructorCanvasWidget = AppPreview(components: [
    SchemaNode(
        type: SchemaNodeType.button, position: WidgetPosition(x: 22, y: 22))
  ]);

  void _addButton(String text, Function onPressed) {
    setState(() {
      final widgetWrapper = SchemaNode(
          type: SchemaNodeType.button,
          position: WidgetPosition(x: buttonX, y: buttonY));
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: AppLayout()),
    );
  }
}
