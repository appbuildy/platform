import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/constants.dart';

part 'loader_placeholder.dart';
part 'loader_logo.dart';

class AppLoader extends StatefulWidget {
  final Future<Widget> uiBuilder;
  const AppLoader({Key key, this.uiBuilder}) : super(key: key);

  @override
  _AppLoaderState createState() => _AppLoaderState();
}

class _AppLoaderState extends State<AppLoader> {
  Widget body;

  @override
  void initState() {
    super.initState();

    body = LoaderPlaceholder();

    /// wait until loaded or for minLoadingAnimationDuration
    Future.wait([
      Future.delayed(appConst.minLoadingDuration),
      widget.uiBuilder.then(
        (Widget loadedPreview) => body = loadedPreview,
      ),
    ]).then(
      (_) => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() {});
      }),
    );
  }

  @override
  Widget build(BuildContext context) => body;
}
