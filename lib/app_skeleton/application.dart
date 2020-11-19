import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/app_skeleton/screen.dart';
import 'package:flutter_app/app_skeleton/store/screen_store.dart';
import 'package:flutter_app/utils/RandomKey.dart';
import 'package:provider/provider.dart';

class Application extends StatefulWidget {
  final Map<RandomKey, Screen> screens;

  Application({Key key, this.screens}) : super(key: key);
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      Provider<ScreenStore>(
          create: (_) => ScreenStore(widget.screens.values.first))
    ], child: MaterialApp(home: widget.screens.values.first));
  }
}
