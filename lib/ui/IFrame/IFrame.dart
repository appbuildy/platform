import 'dart:html';

import 'package:flutter/material.dart';

import './UiFake.dart' if (dart.library.html) 'dart:ui' as ui;

class IFrame extends StatefulWidget {
  final String src;

  const IFrame({Key key, @required this.src}) : super(key: key);

  @override
  _IFrameState createState() => _IFrameState();
}

class _IFrameState extends State<IFrame> {
  Widget _iframeWidget;

  final IFrameElement _iframeElement = IFrameElement();

  @override
  void initState() {
    super.initState();

    _iframeElement.height = '500';
    _iframeElement.width = '500';

    _iframeElement.src = widget.src;
    _iframeElement.style.border = 'none';

    ui.platformViewRegistry.registerViewFactory(
      'iframeElement',
      (int viewId) => _iframeElement,
    );

    _iframeWidget = HtmlElementView(
      key: UniqueKey(),
      viewType: 'iframeElement',
    );
  }

  @override
  Widget build(BuildContext context) {
    return _iframeWidget;
  }
}
