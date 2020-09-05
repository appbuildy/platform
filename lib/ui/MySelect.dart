import 'package:flutter/material.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_app/ui/HoverDecoration.dart';
import 'package:flutter_app/ui/MyColors.dart';

class SelectOption {
  final String name;
  final String value;

  SelectOption(this.name, this.value);
}

class MySelect extends StatefulWidget {
  final String selectedValue;
  final List<SelectOption> options;
  final Function(SelectOption) onChange;

  const MySelect({Key key, this.selectedValue, this.options, this.onChange})
      : super(key: key);

  @override
  _MySelectState createState() => _MySelectState();
}

class _MySelectState extends State<MySelect> {
  OverlayEntry _overlayEntry;
  bool isOverlayOpen;

  Widget buildSelectPreview() {
    final defaultDecoration = BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        gradient: LinearGradient(
          begin: AlignmentDirectional.topCenter,
          end: AlignmentDirectional.bottomCenter,
          colors: [Color(0xFFFFFFFF), Color(0xFFf1f2f9)],
        ),
        border:
            Border.all(width: 1, color: Color(0xFF787878).withOpacity(0.35)),
        boxShadow: []);

    final hoverDecoration = BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        gradient: LinearGradient(
          begin: AlignmentDirectional.topCenter,
          end: AlignmentDirectional.bottomCenter,
          colors: [Color(0xFFFFFFFF), Color(0xFFddf3ff)],
        ),
        border:
            Border.all(width: 1, color: Color(0xFF787878).withOpacity(0.35)),
        boxShadow: []);

    final selectedOption = widget.options
        .where((option) => option.value == widget.selectedValue)
        .first;

    return Cursor(
        cursor: CursorEnum.pointer,
        child: Container(
          decoration: defaultDecoration,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 9, bottom: 8, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Text(
                  selectedOption.name,
                  style: MyTextStyle.regularTitle,
                )),
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
                  left: offset.dx - 11,
                  top: offset.dy,
                  width: size.width + 22,
                  child: Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 10,
                          right: 10,
                          bottom: 10,
                          top: size.height + 5),
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
                                width: 1,
                                color: Color(0xFF787878).withOpacity(0.35)),
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