import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/layout/AppLayout.dart';
import 'package:flutter_app/features/schemaInteractions/SetupUserActions.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/ui/ProjectLoading/ProjectLoadingAnimation.dart';


class ProjectSetupMiddleware extends StatefulWidget {
  @override
  _ProjectSetupMiddlewareState createState() => _ProjectSetupMiddlewareState();
}

class _ProjectSetupMiddlewareState extends State<ProjectSetupMiddleware> {
  final int minLoadingAnimationDurationTime = 1000;

  UserActions userActions;
  OverlayEntry _overlayEntry;
  Stopwatch animationStopwatch;

  OverlayEntry _renderLoadingOverlay() {
    return OverlayEntry(builder: (BuildContext context) => ProjectLoadingAnimation());
  }

  void setupProject() async {
    await userActions.loadProject();

    int elapsedTime = animationStopwatch.elapsedMilliseconds;

    if (elapsedTime > minLoadingAnimationDurationTime) {
      _overlayEntry.remove();
    } else {
      Future.delayed(Duration(milliseconds: minLoadingAnimationDurationTime - elapsedTime))
          .then((value) => _overlayEntry.remove());
    }
  }

  void initState() {
    userActions = setupUserActions();

    this._overlayEntry = this._renderLoadingOverlay();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Overlay.of(context).insert(this._overlayEntry);
      animationStopwatch = Stopwatch()..start();

      this.setupProject();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(userActions: userActions);
  }
}