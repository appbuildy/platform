import 'dart:html';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

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

    final UniqueKey key = UniqueKey();
    ui.platformViewRegistry.registerViewFactory(
      'iframeElement$key',
      (int viewId) => _iframeElement,
    );

    _iframeWidget = HtmlElementView(
      key: UniqueKey(),
      viewType: 'iframeElement$key',
    );
  }

  @override
  Widget build(BuildContext context) {
    return _iframeWidget;
  }
}
