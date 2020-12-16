import 'package:flutter/material.dart';
import 'package:flutter_app/app_skeleton/loading/browser_preview.dart';
import 'package:flutter_app/ui/ProjectLoading/ProjectLoadingAnimation.dart';

class ApplicationWidget extends StatefulWidget {
  final BrowserPreview preview;

  const ApplicationWidget({
    Key key,
    BrowserPreview preview = const BrowserPreview(),
  })  : this.preview = preview ?? const BrowserPreview(),
        super(key: key);

  @override
  _ApplicationWidgetState createState() => _ApplicationWidgetState();
}

class _ApplicationWidgetState extends State<ApplicationWidget> {
  static const Duration minLoadingAnimationDurationTime = Duration(seconds: 1);

  Widget body;

  @override
  void initState() {
    super.initState();
    body = ProjectLoadingAnimation();
    Future.wait([
      Future.delayed(minLoadingAnimationDurationTime),
      widget.preview.load().then((Widget loadedPreview) =>
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              body = loadedPreview;
            });
          }))
    ]);
  }

  @override
  Widget build(BuildContext context) => body;
}
