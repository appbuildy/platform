import 'package:flutter/material.dart';

class HoverDecoration extends StatefulWidget {
  final Widget child;
  final BoxDecoration defaultDecoration;
  final BoxDecoration hoverDecoration;

  const HoverDecoration(
      {Key key,
      @required this.child,
      @required this.defaultDecoration,
      @required this.hoverDecoration})
      : super(key: key);
  @override
  _HoverDecorationState createState() => _HoverDecorationState();
}

class _HoverDecorationState extends State<HoverDecoration>
    with SingleTickerProviderStateMixin {
  BoxDecoration _decoration;

  @override
  void initState() {
    super.initState();
    _decoration = widget.defaultDecoration;
  }

  @override
  void didUpdateWidget(HoverDecoration oldWidget) {
    super.didUpdateWidget(oldWidget);
    _decoration = widget.defaultDecoration;
  }

  void _onHover(e) {
    setState(() {
      _decoration = widget.hoverDecoration;
    });
  }

  void _onExit(e) {
    setState(() {
      _decoration = widget.defaultDecoration;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: _onHover,
      onExit: _onExit,
      child: AnimatedContainer(
        child: widget.child,
        decoration: _decoration,
        duration: Duration(milliseconds: 200),
      ),
    );
  }
}
