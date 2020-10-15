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
  UserActions userActions;
  OverlayEntry _overlayEntry;

  OverlayEntry _renderLoadingOverlay() {
    return OverlayEntry(builder: (BuildContext context) => ProjectLoadingAnimation());
  }

  void setupProject() async {
    await userActions.loadProject();

    _overlayEntry.remove();
  }

  void initState() {
    userActions = setupUserActions();

    this._overlayEntry = this._renderLoadingOverlay();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Overlay.of(context).insert(this._overlayEntry);
      this.setupProject();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(userActions: userActions);
  }
}