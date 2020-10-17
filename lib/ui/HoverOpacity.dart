import 'package:flutter/material.dart';

class HoverOpacity extends StatefulWidget {
  final Widget child;
  final double defaultOpacity;
  final double hoverOpacity;
  final Duration duration;

  const HoverOpacity(
      {Key key,
      @required this.child,
      this.defaultOpacity = 1,
      this.hoverOpacity = 0.85,
      this.duration})
      : super(key: key);

  @override
  _HoverOpacityState createState() => _HoverOpacityState();
}

class _HoverOpacityState extends State<HoverOpacity>
    with SingleTickerProviderStateMixin {
  double _opacity;

  @override
  void initState() {
    super.initState();
    _opacity = widget.defaultOpacity;
  }

  @override
  void didUpdateWidget(HoverOpacity oldWidget) {
    super.didUpdateWidget(oldWidget);
    _opacity = widget.defaultOpacity;
  }

  void _onHover(e) {
    setState(() {
      _opacity = widget.hoverOpacity;
    });
  }

  void _onExit(e) {
    setState(() {
      _opacity = widget.defaultOpacity;
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
      child: AnimatedOpacity(
        child: widget.child,
        opacity: _opacity,
        duration: widget.duration ?? Duration(milliseconds: 0),
      ),
    );
  }
}
