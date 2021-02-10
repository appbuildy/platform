import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/features/schemaNodes/GoToScreenAction.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/my_do_nothing_action.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaDoubleProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaIconProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaMyThemePropProperty.dart';
import 'package:flutter_app/shared_widgets/map.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_app/ui/ColumnDivider.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import 'SchemaNodeSpawner.dart';
import 'implementations.dart';

class SchemaNodeMap extends SchemaNode implements DataContainer {
  SchemaNodeMap({
    @required SchemaNodeSpawner parent,
    UniqueKey id,
    Offset position,
    Offset size,
    Map<String, SchemaNodeProperty> properties,
    GoToScreenAction tapAction,
    Map<String, SchemaNodeProperty> actions,
  }) : super() {
    this.parentSpawner = parent;
    this.type = SchemaNodeType.map;
    this.position = position ?? Offset(0, 0);
    this.size = size ?? Offset(200, 200);
    this.id = id ?? UniqueKey();
    this.actions = actions ?? {'Tap': MyDoNothingAction('Tap')};
    this.properties = properties ??
        {
          'Bearing': SchemaDoubleProperty('Bearing', _kLake.bearing),
          'TargetLatitude':
              SchemaDoubleProperty('TargetLatitude', _kLake.target.latitude),
          'TargetLongitude':
              SchemaDoubleProperty('TargetLongitude', _kLake.target.longitude),
          'Tilt': SchemaDoubleProperty('Tilt', _kLake.tilt),
          'Zoom': SchemaDoubleProperty('Zoom', _kLake.zoom),
          'Icon': SchemaIconProperty('Icon', FontAwesomeIcons.mapMarkerAlt),
          'IconColor': SchemaMyThemePropProperty(
              'IconColor', parent.userActions.currentTheme.primary),
        };

//    this.setBitmapDescriptor();
  }

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

//  Completer<GoogleMapController> _controller = Completer();

  @override
  SchemaNode copy(
      {Offset position,
      Offset size,
      UniqueKey id,
      bool saveProperties = true}) {
    return parentSpawner.spawnSchemaNodeMap(
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

  @override
  Widget toWidget({MyTheme theme, bool isPlayMode}) {
    print('ID ID ID ${Key(this.id.toString())}');
    return new MapView(
      key: Key(this.id.toString()),
      properties: this.properties,
      size: this.size,
      theme: theme,
    );
  }

  @override
  Widget toWidgetWithReplacedData(
      {bool isPlayMode, String data, MyTheme theme = null}) {
    // TODO: implement toWidgetWithReplacedData
    return this.toWidget(isPlayMode: isPlayMode);
  }

  @override
  Widget toEditProps(wrapInRootProps,
      Function(SchemaNodeProperty, [bool, dynamic]) changePropertyTo) {
    return wrapInRootProps(
      Column(children: [
        ColumnDivider(name: 'Data'),
        Row(children: [
          Text(
            'Latitude',
            style: MyTextStyle.regularCaption,
          ),
          SizedBox(
            width: 15,
          ),
//          Expanded(
//            child: MyTextField(
//                defaultValue: properties['TargetLatitude'].value.toString(),
//                onChanged: (String value) {
//                  changePropertyTo(SchemaDoubleProperty(
//                      'TargetLatitude', double.parse(value)));
//                  _goToLatLng(this.latitudeLongitude);
//                }),
//          )
        ]),
        Row(children: [
          Text(
            'Longitude',
            style: MyTextStyle.regularCaption,
          ),
          SizedBox(
            width: 15,
          ),
//          Expanded(
//            child: MyTextField(
//                defaultValue: properties['TargetLongitude'].value.toString(),
//                onChanged: (String value) {
//                  changePropertyTo(SchemaDoubleProperty(
//                      'TargetLongitude', double.parse(value)));
//                  _goToLatLng(this.latitudeLongitude);
//                }),
//          )
        ]),
//        EditPropsColor(
//          currentTheme: parentSpawner.userActions.themeStore.currentTheme,
//          properties: properties,
//          changePropertyTo: (schemaNodeProperty, [bool, dynamic]) {
//            changePropertyTo(schemaNodeProperty);
//
//            this.setBitmapDescriptor();
//            this.updateMarkers();
//          },
//          propName: 'IconColor',
//        ),
//        SelectIconList(
//            subListHeight: 470,
//            selectedIcon: this.properties['Icon'].value,
//            onChanged: (IconData icon) async {
//              await setBitmapDescriptor(icon);
//              updateMarkers();
//              changePropertyTo(SchemaIconProperty('Icon', icon));
//            })
      ]),
    );
  }
}
