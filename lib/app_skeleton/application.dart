import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/app_skeleton/entities/skeleton_screen.dart';
import 'package:flutter_app/app_skeleton/scaling_screen_scaffold.dart';
import 'package:flutter_app/app_skeleton/store/screen_store.dart';
import 'package:flutter_app/utils/RandomKey.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class Application extends StatefulWidget {
  final Map<RandomKey, SkeletonScreen> screens;

  Application({Key key, this.screens}) : super(key: key);
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    var routes = widget.screens.map((key, screen) {
      return MapEntry(
        key.toString(),
        (context) => ScalingScreenScaffold(screen: screen),
      );
    });
    final screenStore =
        ScreenStore(widget.screens.values.first, widget.screens);
    return MultiProvider(
      providers: [
        Provider<ScreenStore>(create: (_) => screenStore),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: routes,
        home: Observer(
          builder: (_) =>
              ScalingScreenScaffold(screen: screenStore.currentScreen),
        ),
      ),
    );
  }
}

// ScreenStore screenStore;
// Map<RandomKey, SkeletonScreen> get screenMap => widget.screens;

// @override
// void initState() {
//   super.initState();
//   screenStore = ScreenStore(
//     widget.screens.values.first,
//     widget.screens,
//   );
// }

// Route<dynamic> onGenerateRoute(RouteSettings settings) {
//   if (settings.name == '/') {
//     // return first one
//     return CupertinoPageRoute<void>(
//       builder: (BuildContext context) => ScalingScreenScaffold(
//         screen: screenMap.values.first,
//       ),
//       settings: settings,
//     );
//   }
//   if (screenStore?.currentScreen != null) {
//     return CupertinoPageRoute<void>(
//       builder: (BuildContext context) => ScalingScreenScaffold(
//         screen: screenStore.currentScreen,
//       ),
//       settings: settings,
//     );
//   } else {
//     return CupertinoPageRoute<void>(
//       builder: (BuildContext context) =>
//           Container(child: Text('Empty screen list')),
//       settings: settings,
//     );
//   }

//   // if (screenMap?.isNotEmpty == true) {
//   //   final RandomKey routeKey = RandomKey.fromString(settings.name);
//   //   if (screenMap.containsKey(routeKey)) {
//   //     return CupertinoPageRoute<void>(
//   //       builder: (BuildContext context) => ScalingScreenScaffold(
//   //         screen: screenMap[routeKey],
//   //       ),
//   //       settings: settings,
//   //     );
//   //   } else {
//   //     /// if screen is not found return 404
//   //     /// or else we could return home
//   //     return CupertinoPageRoute<void>(
//   //       builder: (BuildContext context) =>
//   //           Container(child: Text('Screen not found')),
//   //       settings: settings,
//   //     );
//   //   }
//   // }
// }

// /// build using navigator
// @override
// Widget build(BuildContext context) {
//   return MultiProvider(
//     providers: [Provider<ScreenStore>(create: (_) => screenStore)],
//     child: MaterialApp(
//       initialRoute: '/',
//       onGenerateRoute: onGenerateRoute,
//       //! home is ignored when there is set initial route
//       // home: Observer(builder: (_) => screenStore.currentScreen)),
//     ),
//   );
// }

/// build using observer
// @override
// Widget build(BuildContext context) {
//   return MultiProvider(
//     providers: [Provider<ScreenStore>(create: (_) => screenStore)],
//     child: MaterialApp(
//       home: Observer(
//         builder: (_) => ScalingScreenScaffold(
//           screen: screenStore.currentScreen,
//         ),
//       ),
//     ),
//   );
// }
// }
