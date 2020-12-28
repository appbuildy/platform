import 'package:flutter/material.dart';
import 'package:flutter_app/ui/HoverDecoration.dart';
import 'package:flutter_app/ui/MyColors.dart';

import 'Cursor.dart';

class WithInfo extends StatefulWidget {
  final Widget child;
  final Offset position;
  final BoxDecoration defaultDecoration;
  final BoxDecoration hoverDecoration;
  final bool isShowAlways;
  final bool isOnLeft;
  final Function onDuplicate;
  final Function onBringFront;
  final Function onSendBack;
  final Function onDelete;

  const WithInfo({
    Key key,
    @required this.child,
    this.position,
    this.defaultDecoration,
    this.hoverDecoration,
    this.onDuplicate,
    this.onDelete,
    this.isShowAlways = false,
    this.isOnLeft = false,
    this.onBringFront,
    this.onSendBack,
  }) : super(key: key);

  @override
  _WithInfoState createState() => _WithInfoState();
}

class _WithInfoState extends State<WithInfo> {
  OverlayEntry _overlayEntry;
  bool isOverlayOpen;
  bool isInfoIconVisible;
  bool isInfoIconActive;

  Widget buildOption(
      {String title,
      Function onTap,
      Widget icon,
      bool isFirst = false,
      bool isLast = false}) {
    BorderRadius borderRadius = BorderRadius.zero;

    if (isFirst || isLast) {
      if (isFirst && isLast) {
        borderRadius = BorderRadius.circular(5);
      } else {
        borderRadius = isFirst
            ? BorderRadius.only(
                topRight: Radius.circular(5), topLeft: Radius.circular(5))
            : BorderRadius.only(
                bottomRight: Radius.circular(5),
                bottomLeft: Radius.circular(5));
      }
    }

    final defaultDecoration = BoxDecoration(
      gradient: MyGradients.plainWhite,
      borderRadius: borderRadius,
    );

    final hoverDecoration = BoxDecoration(
      gradient: MyGradients.lightGray,
      borderRadius: borderRadius,
    );

    return Cursor(
      cursor: CursorEnum.pointer,
      child: HoverDecoration(
        hoverDecoration: hoverDecoration,
        defaultDecoration: defaultDecoration,
        child: Stack(
          children: [
            icon != null
                ? Positioned(top: 5, left: 11, child: icon)
                : Container(),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 40.0,
                  bottom: 8,
                  top: 9,
                ),
                child: Text(
                  title,
                  style: MyTextStyle.regularTitle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
        builder: (context) => Stack(
              overflow: Overflow.visible,
              children: [
                GestureDetector(
                  onTap: () {
                    this._overlayEntry.remove();
                    setState(() {
                      isOverlayOpen = false;
                    });
                  },
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
                Positioned(
                  left: widget.isOnLeft
                      ? offset.dx - 125
                      : offset.dx + size.width - 7,
                  top: widget.isOnLeft
                      ? offset.dy + size.width - 7
                      : offset.dy - 15,
                  width: 170,
                  child: GestureDetector(
                    onTap: () {
                      this._overlayEntry.remove();
                      setState(() {
                        isOverlayOpen = false;
                      });
                    },
                    child: Material(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10,
                                  offset: Offset(0, 2),
                                  spreadRadius: 0,
                                  color: Color(0xFF000000).withOpacity(0.1),
                                )
                              ],
                              border: Border.all(
                                  width: 1, color: MyColors.borderGray),
                              borderRadius: BorderRadius.circular(6)),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                widget.onBringFront != null
                                    ? GestureDetector(
                                        onTap: () {
                                          widget.onBringFront();
                                          this._overlayEntry.remove();
                                          setState(() {
                                            isOverlayOpen = false;
                                          });
                                        },
                                        child: buildOption(
                                          icon: Image.network(
                                            'assets/icons/meta/btn-rearrange-top.svg',
                                            width: 24,
                                            height: 24,
                                            color: MyColors.iconDarkGray,
                                          ),
                                          title: 'Bring to Front',
                                          isFirst: true,
                                        ))
                                    : Container(),
                                widget.onSendBack != null
                                    ? GestureDetector(
                                        onTap: () {
                                          widget.onSendBack();
                                          this._overlayEntry.remove();
                                          setState(() {
                                            isOverlayOpen = false;
                                          });
                                        },
                                        child: buildOption(
                                          icon: Image.network(
                                            'assets/icons/meta/btn-rearrange-bottom.svg',
                                            width: 24,
                                            height: 24,
                                            color: MyColors.iconDarkGray,
                                          ),
                                          title: 'Send to Back',
                                          isFirst: true,
                                        ))
                                    : Container(),
                                widget.onDuplicate != null
                                    ? GestureDetector(
                                        onTap: () {
                                          widget.onDuplicate();
                                          this._overlayEntry.remove();
                                          setState(() {
                                            isOverlayOpen = false;
                                          });
                                        },
                                        child: buildOption(
                                          icon: Image.network(
                                            'assets/icons/meta/btn-duplicate.svg',
                                            width: 24,
                                            height: 24,
                                            color: MyColors.iconDarkGray,
                                          ),
                                          title: 'Duplicate',
                                          isFirst: true,
                                          isLast: widget.onDelete == null,
                                        ))
                                    : Container(),
                                widget.onDelete != null
                                    ? GestureDetector(
                                        onTap: () {
                                          widget.onDelete();
                                          this._overlayEntry.remove();
                                          setState(() {
                                            isOverlayOpen = false;
                                          });
                                        },
                                        child: buildOption(
                                          icon: Image.network(
                                            'assets/icons/meta/btn-delete.svg',
                                            width: 26,
                                            height: 26,
                                            color: MyColors.iconDarkGray,
                                          ),
                                          title: 'Delete',
                                          isLast: true,
                                        ))
                                    : Container(),
                              ]),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ));
  }

  Widget buildWithHoverDecoration() {
    if (widget.hoverDecoration != null && widget.defaultDecoration != null) {
      return Container(
        decoration: isInfoIconVisible || isOverlayOpen
            ? widget.hoverDecoration
            : widget.defaultDecoration,
        child: widget.child,
      );
    } else {
      return widget.child;
    }
  }

  @override
  void initState() {
    super.initState();
    isInfoIconVisible = false;
    isOverlayOpen = false;
    isInfoIconActive = false;
  }

  void _onHover(e) {
    setState(() {
      isInfoIconVisible = true;
    });
  }

  void _onExit(e) {
    setState(() {
      isInfoIconVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: _onHover,
      onExit: _onExit,
      child: Stack(
        children: [
          buildWithHoverDecoration(),
          isInfoIconVisible || isOverlayOpen || widget.isShowAlways
              ? Positioned(
                  right: widget.position != null ? widget.position.dx : 6.0,
                  top: widget.position != null ? widget.position.dy : 0.0,
                  child: GestureDetector(
                    onTap: () {
                      this._overlayEntry = this._createOverlayEntry();
                      Overlay.of(context).insert(this._overlayEntry);
                      setState(() {
                        isOverlayOpen = true;
                      });
                    },
                    child: MouseRegion(
                      onHover: (e) {
                        setState(() {
                          isInfoIconActive = true;
                        });
                      },
                      onExit: (e) {
                        setState(() {
                          isInfoIconActive = false;
                        });
                      },
                      child: Cursor(
                        cursor: CursorEnum.pointer,
                        child: Container(
                          color: Colors.transparent,
                          child: Image.network(
                            'assets/icons/meta/btn-more.svg',
                            fit: BoxFit.none,
                            color: isInfoIconActive || isOverlayOpen
                                ? null
                                : MyColors.iconDarkGray,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
