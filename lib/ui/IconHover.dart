import 'package:flutter/material.dart';
import 'package:flutter_app/config/colors.dart';

class IconHover extends StatefulWidget {
  final String assetPath;
  final bool isActive;

  const IconHover({Key key, @required this.assetPath, this.isActive = false})
      : super(key: key);

  @override
  _IconHoverState createState() => _IconHoverState();
}

class _IconHoverState extends State<IconHover> {
  bool isHover;

  @override
  void initState() {
    super.initState();
    isHover = false;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (e) {
        setState(() {
          isHover = true;
        });
      },
      onExit: (e) {
        setState(() {
          isHover = false;
        });
      },
      child: Image.network(
        widget.assetPath,
        color: (isHover || widget.isActive) ? null : MyColors.iconDarkGray,
      ),
    );
  }
}
