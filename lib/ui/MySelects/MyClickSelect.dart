import 'package:flutter/material.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_app/ui/HoverDecoration.dart';
import 'package:flutter_app/ui/MyColors.dart';

import 'SelectOption.dart';

class MyClickSelect extends StatefulWidget {
  final dynamic selectedValue;
  final List<SelectOption> options;
  final Function(SelectOption) onChange;
  final String placeholder;
  final bool isOpenOnTop;

  const MyClickSelect(
      {Key key,
      @required this.selectedValue,
      @required this.options,
      @required this.onChange,
      this.placeholder,
      this.isOpenOnTop = false})
      : super(key: key);

  @override
  _MyClickSelectState createState() => _MyClickSelectState();
}

class _MyClickSelectState extends State<MyClickSelect> {
  OverlayEntry _overlayEntry;
  bool isOverlayOpen;

  Widget buildSelectPreview() {
    final defaultDecoration = BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        gradient: isOverlayOpen
            ? MyGradients.buttonLightBlue
            : MyGradients.buttonLightGray,
        border: Border.all(width: 1, color: MyColors.borderGray));

    final hoverDecoration = BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        gradient: MyGradients.buttonLightBlue,
        border: Border.all(width: 1, color: MyColors.borderGray));

    final dynamic selectedOption = widget.selectedValue != null
        ? widget.options
            .where((option) => option.value == widget.selectedValue)
            .first
        : null;

    return Cursor(
        cursor: CursorEnum.pointer,
        child: HoverDecoration(
          hoverDecoration: hoverDecoration,
          defaultDecoration: defaultDecoration,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 9, bottom: 8, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (selectedOption != null && selectedOption.leftWidget != null)
                    ? Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: selectedOption.leftWidget)
                    : Container(),
                Expanded(
                  child: Container(
                      child: Text(
                    selectedOption != null
                        ? selectedOption.name
                        : widget.placeholder,
                    style: MyTextStyle.regularTitle,
                  )),
                ),
                Image.network(
                  'assets/icons/meta/expand-vertical.svg',
                  color: MyColors.iconGray,
                ),
              ],
            ),
          ),
        ));
  }

  Widget buildOption(SelectOption option, {bool isFirst, bool isLast}) {
    final isActive = option.value == widget.selectedValue;
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

    final defaultDecoration = isActive
        ? BoxDecoration(
            gradient: MyGradients.lightBlue,
            borderRadius: borderRadius,
          )
        : BoxDecoration(
            gradient: MyGradients.plainWhite,
            borderRadius: borderRadius,
          );

    final hoverDecoration = isActive
        ? BoxDecoration(
            gradient: MyGradients.lightBlue,
            borderRadius: borderRadius,
          )
        : BoxDecoration(
            gradient: MyGradients.lightGray,
            borderRadius: borderRadius,
          );

    return Cursor(
      cursor: isActive ? CursorEnum.defaultCursor : CursorEnum.pointer,
      child: HoverDecoration(
        hoverDecoration: hoverDecoration,
        defaultDecoration: defaultDecoration,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, top: 9, bottom: 8, right: 16),
          child: Row(
            children: [
              option.leftWidget != null
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: option.leftWidget)
                  : Container(),
              Expanded(
                child: Text(
                  option.name,
                  style: MyTextStyle.regularTitle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    final firstValue = widget.options.first.value;
    final lastValue = widget.options.last.value;

    return OverlayEntry(
        builder: (context) => Stack(
              overflow: Overflow.visible,
              children: [
                Positioned(
                    child: GestureDetector(
                  onTap: () {
                    this._overlayEntry.remove();
                    setState(() {
                      isOverlayOpen = false;
                    });
                  },
                  child: Container(
                    color: Colors.transparent,
                  ),
                )),
                Positioned(
                  left: offset.dx,
                  top: widget.isOpenOnTop
                      ? offset.dy - size.height - 5
                      : offset.dy + size.height + 5,
                  width: size.width,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(width: 1, color: MyColors.borderGray),
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              offset: Offset(0, 2),
                              spreadRadius: 0,
                              color: Color(0xFF000000).withOpacity(0.1),
                            )
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: widget.options
                            .map((option) => GestureDetector(
                                  onTap: () {
                                    widget.onChange(option);
                                    this._overlayEntry.remove();
                                    setState(() {
                                      isOverlayOpen = false;
                                    });
                                  },
                                  child: buildOption(option,
                                      isFirst: firstValue == option.value,
                                      isLast: lastValue == option.value),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ));
  }

  @override
  void initState() {
    super.initState();
    isOverlayOpen = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          this._overlayEntry = this._createOverlayEntry();
          Overlay.of(context).insert(this._overlayEntry);
          setState(() {
            isOverlayOpen = true;
          });
        },
        child: buildSelectPreview());
  }
}
