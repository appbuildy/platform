import 'package:flutter/material.dart';
import 'package:flutter_app/app_skeleton/loading/browser_preview.dart';
import 'package:flutter_app/ui/ProjectLoading/ProjectLoadingAnimation.dart';

class ApplicationWidget extends StatefulWidget {
  final BrowserPreview preview;
  ApplicationWidget({
    Key key,
    BrowserPreview preview = const BrowserPreview(),
  })  : this.preview = preview ?? BrowserPreview(),
        super(key: key);

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
      try {
        Overlay.of(context).insert(this._overlayEntry);

        animationStopwatch = Stopwatch()..start();

        onStart();
      } catch (e) {
        preview = widget.preview;
        onStart();
      }
    });
  }

  OverlayEntry _renderLoadingOverlay() {
    return OverlayEntry(
      builder: (BuildContext context) => ProjectLoadingAnimation(),
    );
  }

  void endLoadingAnimation() async {
    try {
      int elapsedTime = animationStopwatch.elapsedMilliseconds;

      if (elapsedTime < minLoadingAnimationDurationTime) {
        await Future.delayed(
          Duration(
            milliseconds: minLoadingAnimationDurationTime - elapsedTime,
          ),
        );
      }

      _overlayEntry.remove();
      animationStopwatch.stop();
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    preview ??= widget.preview;
    this.startLoadingAnimation(onStart: this.initPreview);
    application = Container();
  }

  Future<void> initPreview() async {
    endLoadingAnimation();
  }

  @override
  Widget build(BuildContext context) {
    // return application;
    return FutureBuilder<Widget>(
      future: preview.load(),
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.connectionState == ConnectionState.done)
          return snapshot.data;
        // return Container(child: ProjectLoadingAnimation());
        return Container();
      },
    );
  }
}
