import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsColor.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaCrossAlignmentProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaFontWeightProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaIntProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaMainAlignmentProperty.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/AppThemeStore.dart';
import 'package:flutter_app/ui/IconRectangleButton.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MySelects/MySelects.dart';

class EditPropsFontStyle extends StatelessWidget {
  final Map<String, SchemaNodeProperty> properties;
  final UserActions userActions;
  final AppThemeStore theme;

  const EditPropsFontStyle(
      {Key key,
      @required this.properties,
      @required this.userActions,
      @required this.theme})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        EditPropsColor(
          theme: theme,
          properties: properties,
          userActions: userActions,
          propName: 'FontColor',
        ),
        SizedBox(
          height: 10,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
              width: 59,
              child: Text(
                'Size',
                style: MyTextStyle.regularCaption,
              )),
          Expanded(
            child: MyClickSelect(
                selectedValue: properties['FontSize'].value,
                options: [
                  SelectOption('9', 9),
                  SelectOption('10', 10),
                  SelectOption('11', 11),
                  SelectOption('12', 12),
                  SelectOption('13', 13),
                  SelectOption('14', 14),
                  SelectOption('16', 16),
                  SelectOption('18', 18),
                  SelectOption('24', 24),
                  SelectOption('36', 36),
                  SelectOption('48', 48),
                  SelectOption('56', 56),
                  SelectOption('72', 72),
                  SelectOption('96', 96),
                ],
                onChange: (SelectOption option) {
                  userActions.changePropertyTo(
                      SchemaIntProperty('FontSize', option.value));
                }),
          )
        ]),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: 59,
                child: Text(
                  'Weight',
                  style: MyTextStyle.regularCaption,
                )),
            Expanded(
              child: MyClickSelect(
                  selectedValue: properties['FontWeight'].value,
                  options: [
                    SelectOption('Thin', FontWeight.w100),
                    SelectOption('Light', FontWeight.w300),
                    SelectOption('Regular', FontWeight.w400),
                    SelectOption('Medium', FontWeight.w500),
                    SelectOption('Semi-Bold', FontWeight.w600),
                    SelectOption('Bold', FontWeight.w700),
                    SelectOption('Black', FontWeight.w900),
                  ],
                  onChange: (SelectOption option) {
                    userActions.changePropertyTo(
                        SchemaFontWeightProperty('FontWeight', option.value));
                  }),
            )
          ],
        ),
        SizedBox(
          height: 13,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Alignment',
              style: MyTextStyle.regularCaption,
            ),
            SizedBox(
              height: 9,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    MyIconRectangleButton(
                      onTap: () {
                        userActions.changePropertyTo(
                            SchemaCrossAlignmentProperty(
                                'CrossAlignment', CrossAxisAlignment.start));
                      },
                      isActive: properties['CrossAlignment'].value ==
                          CrossAxisAlignment.start,
                      assetPath: 'assets/icons/text/horizontal-left.svg',
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    MyIconRectangleButton(
                      onTap: () {
                        userActions.changePropertyTo(
                            SchemaCrossAlignmentProperty(
                                'CrossAlignment', CrossAxisAlignment.center));
                      },
                      isActive: properties['CrossAlignment'].value ==
                          CrossAxisAlignment.center,
                      assetPath: 'assets/icons/text/horizontal-center.svg',
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    MyIconRectangleButton(
                      onTap: () {
                        userActions.changePropertyTo(
                            SchemaCrossAlignmentProperty(
                                'CrossAlignment', CrossAxisAlignment.end));
                      },
                      isActive: properties['CrossAlignment'].value ==
                          CrossAxisAlignment.end,
                      assetPath: 'assets/icons/text/horizontal-right.svg',
                    )
                  ],
                ),
                Row(
                  children: [
                    MyIconRectangleButton(
                      onTap: () {
                        userActions.changePropertyTo(
                            SchemaMainAlignmentProperty(
                                'MainAlignment', MainAxisAlignment.start));
                      },
                      isActive: properties['MainAlignment'].value ==
                          MainAxisAlignment.start,
                      assetPath: 'assets/icons/text/vertical-top.svg',
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    MyIconRectangleButton(
                      onTap: () {
                        userActions.changePropertyTo(
                            SchemaMainAlignmentProperty(
                                'MainAlignment', MainAxisAlignment.center));
                      },
                      isActive: properties['MainAlignment'].value ==
                          MainAxisAlignment.center,
                      assetPath: 'assets/icons/text/vertical-center.svg',
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    MyIconRectangleButton(
                      onTap: () {
                        userActions.changePropertyTo(
                            SchemaMainAlignmentProperty(
                                'MainAlignment', MainAxisAlignment.end));
                      },
                      isActive: properties['MainAlignment'].value ==
                          MainAxisAlignment.end,
                      assetPath: 'assets/icons/text/vertical-bottom.svg',
                    )
                  ],
                )
              ],
            ),
          ],
        )
      ],
    );
  }
}
