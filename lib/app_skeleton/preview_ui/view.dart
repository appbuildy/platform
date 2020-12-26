import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/utils/RandomKey.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:flutter_app/app_skeleton/entities/skeleton_entities.dart';
import 'package:flutter_app/app_skeleton/preview_ui/state/preview_state_store.dart';

import 'scaling_screen_scaffold.dart';

class SkeletonPreview extends StatefulWidget {
  final SkeletonProject project;

  const SkeletonPreview({Key key, @required this.project}) : super(key: key);
  @override
  _SkeletonPreviewState createState() => _SkeletonPreviewState();
}

class _SkeletonPreviewState extends State<SkeletonPreview> {
  PreviewStateStore stateStore;

  @override
  void initState() {
    super.initState();
    stateStore = PreviewStateStore(project: widget.project);
  }

  WidgetBuilder buildScreen({SkeletonScreen screenData}) =>
      (BuildContext context) => ScalingScreenScaffold(screen: screenData);

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      // return first one
      return CupertinoPageRoute<void>(
        builder: buildScreen(screenData: stateStore.initialScreen),
        settings: settings,
      );
    }
    return CupertinoPageRoute<void>(
      builder: buildScreen(
        screenData:
            stateStore.project?.screens[RandomKey.fromString(settings.name)] ??
                const _NotFoundScreen(),
      ),
      settings: settings,
    );
  }

  /// build using navigator
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PreviewStateStore>.value(value: stateStore),
      ],
      child: MaterialApp(
        initialRoute: '/',
        onGenerateRoute: onGenerateRoute,
        //! home is ignored when there is set initial route
        home: Observer(
          builder: buildScreen(screenData: stateStore.initialScreen),
        ),
      ),
    );
  }
}

class _NotFoundScreen extends StatelessWidget {
  const _NotFoundScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Text('No screen with such key in project'));
  }
}
