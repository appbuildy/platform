import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/config/colors.dart';
import 'package:flutter_app/config/constants.dart';
import 'package:lottie/lottie.dart';

part 'loader_placeholder.dart';
part 'loader_logo.dart';

class AppLoader extends StatefulWidget {
  final Future<Widget> asyncBuilder;
  const AppLoader({Key key, this.asyncBuilder}) : super(key: key);

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
      widget.asyncBuilder.then(
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
