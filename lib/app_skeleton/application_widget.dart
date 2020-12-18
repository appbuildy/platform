import 'package:flutter/material.dart';
import 'package:flutter_app/app_skeleton/loading/browser_preview.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/ui/ProjectLoading/ProjectLoadingAnimation.dart';

class ApplicationWidget extends StatefulWidget {
  BrowserPreview preview;
  ApplicationWidget({Key key, BrowserPreview preview}) : super(key: key) {
    this.preview = preview ?? BrowserPreview();
  }

  @override
  _ApplicationWidgetState createState() => _ApplicationWidgetState();
}

class _ApplicationWidgetState extends State<ApplicationWidget> {
  Widget body;

  @override
  void initState() {
    super.initState();
    body = ProjectLoadingAnimation();

    /// wait until loaded or for minLoadingAnimationDuration
    Future.wait([
      Future.delayed(appConst.minLoadingDuration),
      widget.preview.load().then(
            (Widget loadedPreview) => body = loadedPreview,
          ),
    ]).then(
      (_) =>
          WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {})),
    );
  }

  @override
  Widget build(BuildContext context) => body;
}
