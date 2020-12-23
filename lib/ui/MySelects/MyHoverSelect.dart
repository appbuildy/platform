import 'package:flutter/material.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_app/ui/HoverDecoration.dart';
import 'package:flutter_app/ui/MyButton.dart';
import 'package:flutter_app/config/colors.dart';

import 'SelectOption.dart';

class MyHoverSelect extends StatefulWidget {
  final dynamic selectedValue;
  final List<SelectOption> options;
  final Function(SelectOption) onChange;
  final Function() onAdd;

  const MyHoverSelect(
      {Key key, this.selectedValue, this.options, this.onChange, this.onAdd})
      : super(key: key);

  @override
  _MyHoverSelectState createState() => _MyHoverSelectState();
}

class _MyHoverSelectState extends State<MyHoverSelect> {
  OverlayEntry _overlayEntry;
  bool isOverlayOpen;

  Widget buildSelectPreview() {
    final defaultDecoration = BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        gradient: MyGradients.buttonLightGray,
        border: Border.all(width: 1, color: MyColors.borderGray),
        boxShadow: []);

    final selectedOption = widget.options
        .where((option) => option.value == widget.selectedValue)
        .first;

    return Cursor(
      cursor: CursorEnum.pointer,
      child: Container(
        height: 36,
        width: 250,
        decoration: defaultDecoration,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                selectedOption.name,
                // : '${selectedOption.name.substring(0, 20)}...',
                overflow: TextOverflow.ellipsis,
                style: MyTextStyle.regularTitle,
              ),
            ),
            Image.network(
              'assets/icons/meta/expand-vertical.svg',
              color: MyColors.iconGray,
            ),
          ],
          // ),
        ),
      ),
    );
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

    return Row(
      children: [
        Expanded(
          child: Cursor(
            cursor: isActive ? CursorEnum.defaultCursor : CursorEnum.pointer,
            child: HoverDecoration(
              hoverDecoration: hoverDecoration,
              defaultDecoration: defaultDecoration,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16, top: 9, bottom: 8, right: 16),
                child: Text(
                  option.name,
                  style: MyTextStyle.regularTitle,
                ),
              ),
            ),
          ),
        ),
      ],
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
                    child: MouseRegion(
                  onEnter: (e) {
                    this._overlayEntry.remove();
                    setState(() {
                      isOverlayOpen = false;
                    });
                  },
                  child: Container(),
                )),
                Positioned(
                  left: offset.dx,
                  top: offset.dy,
                  width: size.width,
                  child: Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: EdgeInsets.only(top: size.height + 5),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    width: 1, color: MyColors.borderGray),
                                borderRadius: BorderRadius.circular(6)),
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
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: MyButton(
                              text: 'Add Page',
                              icon: Image.network(
                                  'assets/icons/meta/btn-plus.svg'),
                              onTap: () {
                                widget.onAdd();
                                this._overlayEntry.remove();
                                setState(() {
                                  isOverlayOpen = false;
                                });
                              },
                            ),
                          )
                        ],
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
    return MouseRegion(
        onEnter: (e) {
          this._overlayEntry = this._createOverlayEntry();
          Overlay.of(context).insert(this._overlayEntry);
          setState(() {
            isOverlayOpen = true;
          });
        },
        child: buildSelectPreview());
  }
}
