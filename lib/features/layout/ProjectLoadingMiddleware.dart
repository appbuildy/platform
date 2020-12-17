import 'package:flutter/cupertino.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/features/layout/AppLayout.dart';
import 'package:flutter_app/features/schemaInteractions/SetupUserActions.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/ui/ProjectLoading/ProjectLoadingAnimation.dart';

class ProjectSetupMiddleware extends StatefulWidget {
  @override
  _ProjectSetupMiddlewareState createState() => _ProjectSetupMiddlewareState();
}

class _ProjectSetupMiddlewareState extends State<ProjectSetupMiddleware> {
  UserActions userActions;
  Widget body;

  void initState() {
    super.initState();
    body = ProjectLoadingAnimation();
    userActions = setupUserActions();

    /// wait until loaded or for minLoadingAnimationDuration
    Future.wait([
      Future.delayed(appConst.minLoadingDuration),
      userActions.loadProject().then(
            (_) => body = AppLayout(userActions: userActions),
          ),
    ]).then(
      (_) =>
          WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {})),
    );
  }

  @override
  Widget build(BuildContext context) => body;
}
