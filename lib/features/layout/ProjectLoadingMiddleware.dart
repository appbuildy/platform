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

  void initState() {
    userActions = setupUserActions();

    this.startLoadingAnimation(onStart: this.setupProject);

    super.initState();
  }

  void startLoadingAnimation({@required Function onStart}) {
    this._overlayEntry = this._renderLoadingOverlay();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Overlay.of(context).insert(this._overlayEntry);

      animationStopwatch = Stopwatch()..start();

      onStart();
    });
  }

  OverlayEntry _renderLoadingOverlay() {
    return OverlayEntry(
        builder: (BuildContext context) => ProjectLoadingAnimation());
  }

  void setupProject() async {
    try {
      await userActions.loadProject();
      this.endLoadingAnimation();
    } catch (e) {
      this.endLoadingAnimation();
    }
  }

  void endLoadingAnimation() async {
    int elapsedTime = animationStopwatch.elapsedMilliseconds;

    if (elapsedTime < minLoadingAnimationDurationTime) {
      await Future.delayed(Duration(
          milliseconds: minLoadingAnimationDurationTime - elapsedTime));
    }

    _overlayEntry.remove();
    animationStopwatch.stop();
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(userActions: userActions);
  }
}
