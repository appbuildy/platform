import 'package:flutter/material.dart';
import 'package:flutter_app/canvas/WidgetPosition.dart';
import 'package:flutter_app/canvas/WidgetWrapper.dart';

import 'canvas/ConstructorCanvasWidget.dart';

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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int buttonX;
  int buttonY;
  ConstructorCanvasWidget constructorCanvasWidget =
      ConstructorCanvasWidget(components: [
    WidgetWrapper(
        flutterWidget: MaterialButton(
            color: Colors.greenAccent, onPressed: () {}, child: Text('322')),
        position: WidgetPosition(x: 22, y: 22))
  ]);

  void _addButton(String text, Function onPressed) {
    setState(() {
      final widgetWrapper = WidgetWrapper(
          flutterWidget: MaterialButton(
              color: Colors.green, onPressed: onPressed, child: Text(text)),
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
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            constructorCanvasWidget,
            Text(
              'You have psdasdasdushed the button this many times:',
            ),
            Text('Coord x: $buttonX, coord y: $buttonY'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Container(
              width: 50,
              color: Colors.green,
              child: TextField(
                onChanged: (text) {
                  setState(() {
                    buttonY = int.tryParse(text);
                  });
                },
              ),
            ),
            Container(
              width: 50,
              color: Colors.greenAccent,
              child: TextField(
                onChanged: (text) {
                  setState(() {
                    buttonX = int.tryParse(text);
                  });
                },
              ),
            ),
            MaterialButton(
              child: Text('AddButton'),
              onPressed: () {
                setState(() {
                  _addButton('Button $buttonX ,$buttonY', () {});
                });
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Add button',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
