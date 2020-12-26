import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/config/text_styles.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_app/ui/HoverDecoration.dart';
import 'package:flutter_app/config/colors.dart';

import 'SelectOption.dart';

class MyClickSelect extends StatefulWidget {
  final dynamic selectedValue;
  final List<SelectOption> options;
  final Function(SelectOption) onChange;
  final String placeholder;
  final bool disabled;
  final Widget defaultIcon;

  final bool dropDownOnLeftSide;
  final Widget defaultPreview;

  const MyClickSelect({
    Key key,
    @required this.selectedValue,
    @required this.options,
    @required this.onChange,
    this.placeholder,
    this.disabled = false,
    this.defaultIcon,
    this.defaultPreview,
    this.dropDownOnLeftSide = false,
  }) : super(key: key);

  @override
  _MyClickSelectState createState() => _MyClickSelectState();
}

class _MyClickSelectState extends State<MyClickSelect> {
  OverlayEntry _overlayEntry;
  bool isOverlayOpen;

  Widget buildSelectPreview() {
    BoxDecoration defaultDecoration;
    BoxDecoration hoverDecoration;

    if (widget.disabled) {
      defaultDecoration = BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          gradient: MyGradients.buttonDisabledGray,
          border:
              Border.all(width: 1, color: Color(0xFF666666).withOpacity(0.3)));

      hoverDecoration = BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          gradient: MyGradients.buttonDisabledGray,
          border:
              Border.all(width: 1, color: Color(0xFF666666).withOpacity(0.3)));
    } else {
      defaultDecoration = BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          gradient: isOverlayOpen
              ? MyGradients.buttonLightBlue
              : MyGradients.buttonLightGray,
          border: Border.all(width: 1, color: MyColors.borderGray));

      hoverDecoration = BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          gradient: MyGradients.buttonLightBlue,
          border: Border.all(width: 1, color: MyColors.borderGray));
    }

    final dynamic selectedOption =
        widget.selectedValue != null && widget.options != null
            ? widget.options.firstWhere(
                (option) => option.value == widget.selectedValue,
                orElse: () => null)
            : null;

    bool isWithIcon = widget.defaultIcon != null ||
        (selectedOption != null && selectedOption.leftWidget != null);

    return Cursor(
        cursor: widget.disabled ? CursorEnum.defaultCursor : CursorEnum.pointer,
        child: HoverDecoration(
          hoverDecoration: hoverDecoration,
          defaultDecoration: defaultDecoration,
          child: Padding(
            padding: EdgeInsets.only(
                top: 9, bottom: 8, left: isWithIcon ? 10 : 16, right: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isWithIcon
                    ? Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: widget.defaultIcon != null
                            ? widget.defaultIcon
                            : selectedOption.leftWidget)
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

    final windowSize = MediaQuery.of(context).size;

    final calculatedHeight =
        ((size.height - 2) * widget.options.length) + size.height;
    final calculatedSum = calculatedHeight + offset.dy;

    double yPosition = offset.dy;
    double xPosition = offset.dx;
    if (calculatedSum >= windowSize.height) {
      yPosition += ((size.height - 2) * widget.options.length * -1) - 6;
    } else if (widget.dropDownOnLeftSide) {
      xPosition -= size.width + 5;
    } else {
      yPosition += size.height + 5;
    }

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
                  left: xPosition,
                  top: yPosition,
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
    return AbsorbPointer(
      absorbing: widget.disabled,
      child: GestureDetector(
          onTap: () {
            this._overlayEntry = this._createOverlayEntry();
            Overlay.of(context).insert(this._overlayEntry);
            setState(() {
              isOverlayOpen = true;
            });
          },
          child: widget.defaultPreview != null
              ? widget.defaultPreview
              : buildSelectPreview()),
    );
  }
}
