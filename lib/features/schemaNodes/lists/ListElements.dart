import 'package:flutter/cupertino.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MySwitch.dart';

import '../SchemaNodeProperty.dart';

class ListElementsProperty extends SchemaNodeProperty<ListElements> {
  ListElementsProperty(String name, ListElements value) : super(name, value);

  @override
  ListElementsProperty copy() {
    return ListElementsProperty(this.name, value);
  }
}

class ListElements {
  ListElement title;
  ListElement subtitle;
  ListElement image;
  ListElement navigationIcon;

  Widget toEditProps() {
    return Column(
      children: [
        ListElementWidget(
          type: ListElementType.title,
          name: "Title",
          parent: this,
        ),
        ListElementWidget(
          type: ListElementType.subtitle,
          name: "Subtitle",
          parent: this,
        ),
        ListElementWidget(
          type: ListElementType.image,
          name: "Image",
          parent: this,
        ),
        ListElementWidget(
          type: ListElementType.navigationIcon,
          name: "Arrow",
          parent: this,
        ),
      ],
    );
  }

  ListElements({title, subtitle, image, navigationIcon}) {
    this.title = title;
    this.subtitle = subtitle;
    this.image = image;
    this.navigationIcon = navigationIcon;
  }
}

class ListElementWidget extends StatefulWidget {
  final ListElementType type;
  final String name;
  final ListElements parent;

  const ListElementWidget(
      {Key key,
      @required this.parent,
      @required this.type,
      @required this.name})
      : super(key: key);

  @override
  _ListElementWidgetState createState() => _ListElementWidgetState();
}

class _ListElementWidgetState extends State<ListElementWidget> {
  dynamic _getElement([bool isOnTap = false]) {
    if (widget.type == ListElementType.title) {
      return isOnTap
          ? () {
              widget.parent.title = widget.parent.title == null
                  ? ListElement(type: ListElementType.title, column: 'default')
                  : null;
            }
          : widget.parent.title;
    } else if (widget.type == ListElementType.subtitle) {
      return isOnTap
          ? () {
              widget.parent.subtitle = widget.parent.subtitle == null
                  ? ListElement(
                      type: ListElementType.subtitle, column: 'default')
                  : null;
            }
          : widget.parent.subtitle;
    } else if (widget.type == ListElementType.image) {
      return isOnTap
          ? () {
              widget.parent.image = widget.parent.image == null
                  ? ListElement(type: ListElementType.image, column: 'default')
                  : null;
            }
          : widget.parent.image;
    } else if (widget.type == ListElementType.navigationIcon) {
      return isOnTap
          ? () {
              widget.parent.navigationIcon =
                  widget.parent.navigationIcon == null
                      ? ListElement(
                          type: ListElementType.navigationIcon,
                          column: 'default')
                      : null;
            }
          : widget.parent.navigationIcon;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.type == ListElementType.title
          ? const EdgeInsets.only()
          : const EdgeInsets.only(top: 11),
      child: Row(
        children: [
          MySwitch(
              value: _getElement() != null,
              onTap: () {
                setState(() {
                  _getElement(true)();
                });
              }),
          SizedBox(width: 11),
          Text(
            widget.name,
            style: MyTextStyle.regularTitle,
          )
        ],
      ),
    );
  }
}

enum ListElementType { title, subtitle, image, navigationIcon }

class ListElement {
  String column;
  ListElementType type;

  ListElement({@required String column, @required ListElementType type}) {
    this.column = column;
    this.type = type;
  }
}