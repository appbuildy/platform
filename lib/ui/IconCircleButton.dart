import 'package:flutter/material.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_app/ui/HoverDecoration.dart';
import 'package:flutter_app/ui/MyColors.dart';

class IconCircleButton extends StatelessWidget {
  final Widget icon;
  final String assetPath;
  final Function onTap;
  final bool isDisabled;

  const IconCircleButton(
      {Key key, this.icon, this.onTap, this.isDisabled = false, this.assetPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultDecoration =
        BoxDecoration(gradient: MyGradients.plainWhite, shape: BoxShape.circle);
    final hoverDecoration =
        BoxDecoration(gradient: MyGradients.lightBlue, shape: BoxShape.circle);

    if (isDisabled) {
      return Container(
        width: 38,
        height: 38,
        decoration: defaultDecoration,
        child: icon,
      );
    }

    return GestureDetector(
      onTap: onTap ?? () {},
      child: Cursor(
        cursor: CursorEnum.pointer,
        child: HoverDecoration(
          hoverDecoration: hoverDecoration,
          defaultDecoration: defaultDecoration,
          child: assetPath != null
              ? IconHover(assetPath: assetPath)
              : Container(
                  width: 38,
                  height: 38,
                  child: icon,
                ),
        ),
      ),
    );
  }
}

class IconHover extends StatefulWidget {
  final String assetPath;

  const IconHover({Key key, this.assetPath}) : super(key: key);

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
        color: isHover ? null : MyColors.iconDarkGray,
      ),
    );
  }
}
