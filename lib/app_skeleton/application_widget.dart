import 'package:flutter/material.dart';
import 'package:flutter_app/app_skeleton/loading/browser_preview.dart';
import 'package:universal_html/html.dart';

class ApplicationWidget extends StatefulWidget {
  BrowserPreview preview;
  ApplicationWidget({Key key, BrowserPreview preview}) : super(key: key) {
    this.preview = preview ?? BrowserPreview();
  }

  @override
  _ApplicationWidgetState createState() => _ApplicationWidgetState();
}

class _ApplicationWidgetState extends State<ApplicationWidget> {
  BrowserPreview preview;
  Widget application;
  bool isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    preview ??= widget.preview;
    initPreview();
  }

  Future<void> initPreview() async {
    try {
      Widget applicationLoad = await preview.load();
      setState(() {
        application = applicationLoad;
        isLoading = false;
      });
    } catch (e) {
      throw (e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _fallbackApp();
    } else {
      return application;
    }
  }

  Widget _fallbackApp() {
    return MaterialApp(
      title: 'Fallback App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(body: Text('App is Loading')),
    );
  }
}
