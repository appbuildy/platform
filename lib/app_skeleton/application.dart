import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/app_skeleton/screen.dart';
import 'package:flutter_app/app_skeleton/store/screen_store.dart';
import 'package:flutter_app/utils/RandomKey.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class Application extends StatefulWidget {
  static Map<RandomKey, Screen> allScreens;
  static Map<RandomKey, Screen> getScreens() => allScreens;
  final Map<RandomKey, Screen> screens;

  Application({Key key, this.screens}) : super(key: key);
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    var routes = widget.screens.map((key, screen) {
      return MapEntry(key.toString(), (context) => screen);
    });
    Application.allScreens = widget.screens;
    final screenStore =
        ScreenStore(widget.screens.values.first, widget.screens);
    return MultiProvider(
        providers: [Provider<ScreenStore>(create: (_) => screenStore)],
        child: MaterialApp(
            initialRoute: '/',
            routes: routes,
            home: Observer(builder: (_) => screenStore.currentScreen)));
  }
}
