import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsCorners.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsText.dart';
import 'package:flutter_app/features/schemaNodes/schemaAction.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MySelects/MyClickSelect.dart';
import 'package:flutter_app/ui/MySelects/MySelects.dart';
import 'package:flutter_app/utils/Debouncer.dart';

class SchemaNodeImage extends SchemaNode {
  Debouncer<String> textDebouncer;

  SchemaNodeImage(
      {Offset position,
      Offset size,
      Map<String, SchemaNodeProperty> properties,
      UniqueKey id})
      : super() {
    this.type = SchemaNodeType.image;
    this.position = position ?? Offset(0, 0);
    this.size = size ?? Offset(150.0, 100.0);
    this.id = id ?? UniqueKey();
    this.actions = actions ?? {'Tap': GoToScreenAction('Tap', null)};
    this.properties = properties ??
        {
          'Url': SchemaStringProperty('Url',
              'https://images.unsplash.com/photo-1549880338-65ddcdfd017b'),
          'BorderRadiusValue': SchemaIntProperty('BorderRadiusValue', 12),
          'Fit': SchemaStringProperty('Fit', 'Fill')
        };
    textDebouncer =
        Debouncer(milliseconds: 500, prevValue: this.properties['Url'].value);
  }

  @override
  SchemaNode copy(
      {Offset position,
      Offset size,
      UniqueKey id,
      bool saveProperties = true}) {
    return SchemaNodeImage(
      position: position ?? this.position,
      id: id ?? this.id,
      size: size ?? this.size,
      properties: saveProperties ? this._copyProperties() : null,
    );
  }

  Map<String, SchemaNodeProperty> _copyProperties() {
    final newProps = Map<String, SchemaNodeProperty>();
    this.properties.forEach((key, value) {
      newProps[key] = value.copy();
    });

    return newProps;
  }

  BoxFit getFitOnString(String fit) {
    if (fit == 'Contain') {
      return BoxFit.contain;
    } else if (fit == 'Cover') {
      return BoxFit.cover;
    } else if (fit == 'Fill') {
      return BoxFit.fill;
    } else if (fit == 'None') {
      return BoxFit.none;
    }
  }

  @override
  Widget toWidget() {
    return Container(
      width: size.dx,
      height: size.dy,
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(properties['BorderRadiusValue'].value)),
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(properties['BorderRadiusValue'].value),
        child: Image.network(
          properties['Url'].value,
          fit: getFitOnString(properties['Fit'].value),
        ),
      ),
    );
  }

  @override
  Widget toEditProps(userActions) {
    return Column(children: [
      EditPropsText(
          title: 'Url',
          id: id,
          properties: properties,
          propName: 'Url',
          userActions: userActions,
          textDebouncer: textDebouncer),
      SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 59,
            child: Text(
              'Resize',
              style: MyTextStyle.regularCaption,
            ),
          ),
          Expanded(
            child: MyClickSelect(
              options: [
                SelectOption('Fill', 'Fill'),
                SelectOption('Cover', 'Cover'),
                SelectOption('Contain', 'Contain'),
                SelectOption('None', 'None')
              ],
              selectedValue: properties['Fit'].value,
              onChange: (SelectOption option) {
                userActions.changePropertyTo(
                    SchemaStringProperty('Fit', option.value));
              },
            ),
          ),
        ],
      ),
      SizedBox(
        height: 15,
      ),
      EditPropsCorners(
        value: properties['BorderRadiusValue'].value,
        onChanged: (int value) {
          userActions
              .changePropertyTo(SchemaIntProperty('BorderRadiusValue', value));
        },
      ),
    ]);
  }
}
