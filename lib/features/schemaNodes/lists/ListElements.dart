import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MySelects/MyClickSelect.dart';
import 'package:flutter_app/ui/MySelects/MySelects.dart';
import 'package:flutter_app/ui/MySwitch.dart';

import '../SchemaNodeProperty.dart';

class ListElementsProperty extends SchemaNodeProperty<ListElements> {
  ListElementsProperty(String name, ListElements value) : super(name, value);

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'propertyClass': 'ListElementsProperty',
      'value': {
        'title': value.title?.toJson(),
        'subtitle': value.subtitle?.toJson(),
        'image': value.image?.toJson(),
        'navigationIcon': value?.navigationIcon,
        'allColumns': value?.allColumns
      }
    };
  }

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
  List<String> allColumns;

  void updateAllColumns(List<String> newAllColumns) {
    allColumns = newAllColumns;

    image.column = newAllColumns[0];
    title.column = allColumns.length >= 2 ? newAllColumns[1] : newAllColumns[0];
    subtitle.column =
        allColumns.length >= 3 ? newAllColumns[2] : newAllColumns[0];
  }

  Widget toEditProps(UserActions userActions) {
    return Column(
      children: [
        ListElementWidget(
          type: ListElementType.image,
          name: "Image",
          parent: this,
          userActions: userActions,
        ),
        ListElementWidget(
          type: ListElementType.title,
          name: "Title",
          parent: this,
          userActions: userActions,
        ),
        ListElementWidget(
          type: ListElementType.subtitle,
          name: "Subtitle",
          parent: this,
          userActions: userActions,
        ),
        ListElementWidget(
          type: ListElementType.navigationIcon,
          name: "Arrow",
          parent: this,
          userActions: userActions,
        ),
      ],
    );
  }

  ListElements({title, subtitle, image, navigationIcon, allColumns}) {
    this.title = title;
    this.subtitle = subtitle;
    this.image = image;
    this.navigationIcon = navigationIcon;
    this.allColumns = allColumns;
  }
}

class ListElementWidget extends StatefulWidget {
  final ListElementType type;
  final String name;
  final ListElements parent;
  final UserActions userActions;

  const ListElementWidget(
      {Key key,
      @required this.parent,
      @required this.type,
      @required this.name,
      @required this.userActions})
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
                  ? ListElement(
                      type: ListElementType.title,
                      column: widget.parent.allColumns[0])
                  : null;

              widget.userActions.changePropertyTo(
                  ListElementsProperty('Elements', widget.parent));
            }
          : widget.parent.title;
    } else if (widget.type == ListElementType.subtitle) {
      return isOnTap
          ? () {
              widget.parent.subtitle = widget.parent.subtitle == null
                  ? ListElement(
                      type: ListElementType.subtitle,
                      column: widget.parent.allColumns.length >= 2
                          ? widget.parent.allColumns[1]
                          : widget.parent.allColumns[0])
                  : null;

              widget.userActions.changePropertyTo(
                  ListElementsProperty('Elements', widget.parent));
            }
          : widget.parent.subtitle;
    } else if (widget.type == ListElementType.image) {
      return isOnTap
          ? () {
              widget.parent.image = widget.parent.image == null
                  ? ListElement(
                      type: ListElementType.image,
                      column: widget.parent.allColumns.length >= 3
                          ? widget.parent.allColumns[2]
                          : widget.parent.allColumns[0])
                  : null;

              widget.userActions.changePropertyTo(
                  ListElementsProperty('Elements', widget.parent));
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

              widget.userActions.changePropertyTo(
                  ListElementsProperty('Elements', widget.parent));
            }
          : widget.parent.navigationIcon;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.type == ListElementType.image
          ? const EdgeInsets.only()
          : const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Row(
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
          SizedBox(
            height: 8,
          ),
          widget.type != ListElementType.navigationIcon && _getElement() != null
              ? Row(
                  children: [
                    Text(
                      'Column',
                      style: MyTextStyle.regularCaption,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: MyClickSelect(
                      placeholder: 'Select Column',
                      defaultIcon: Container(
                          child: Image.network(
                        'assets/icons/meta/btn-detailed-info-big.svg',
                        fit: BoxFit.contain,
                      )),
                      onChange: (SelectOption element) {
                        (_getElement() as ListElement).column = element.value;

                        widget.userActions.changePropertyTo(
                            ListElementsProperty('Elements', widget.parent));
                      },
                      options: widget.parent.allColumns
                          .map((e) => SelectOption(e, e))
                          .toList(),
                      selectedValue: _getElement() != null
                          ? (_getElement() as ListElement).column
                          : null,
                    ))
                  ],
                )
              : Container()
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

  ListElement.fromJson(Map<String, dynamic> jsonVar) {
    this.type = ListElementType.values
        .firstWhere((el) => el.toString() == jsonVar['type']);
    this.column = jsonVar['column'];
  }

  Map<String, dynamic> toJson() {
    return {'column': column, 'type': type.toString()};
  }
}
