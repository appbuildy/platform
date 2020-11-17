import 'package:flutter/material.dart';
import 'package:flutter_app/app_skeleton/loading/browser_preview.dart';
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
  final int minLoadingAnimationDurationTime = 1000;

  BrowserPreview preview;
  Widget application;
  OverlayEntry _overlayEntry;
  Stopwatch animationStopwatch;

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
  void initState() {
    super.initState();
    this.startLoadingAnimation(onStart: this.initPreview);
    preview ??= widget.preview;
    initPreview();
  }

  Future<void> initPreview() async {
    try {
      Widget applicationLoad = await preview.load();
      setState(() {
        application = applicationLoad;
        endLoadingAnimation();
      });
    } catch (e) {
      //throw (e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return application;
  }
}
