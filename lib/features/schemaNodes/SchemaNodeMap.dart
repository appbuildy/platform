import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaDoubleProperty.dart';
import 'package:flutter_app/features/schemaNodes/schemaAction.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_app/ui/ColumnDivider.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MyTextField.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
    this.actions =
        actions ?? {'Tap': tapAction ?? GoToScreenAction('Tap', null)};
    this.properties = properties ??
        {
          'Bearing': SchemaDoubleProperty('Bearing', _kLake.bearing),
          'TargetLatitude': SchemaDoubleProperty('TargetLatitude', _kLake.target.latitude),
          'TargetLongitude': SchemaDoubleProperty('TargetLongitude', _kLake.target.longitude),
          'Tilt': SchemaDoubleProperty('Tilt', _kLake.tilt),
          'Zoom': SchemaDoubleProperty('Zoom', _kLake.zoom),
        };

    this.updateMarkers();
  }

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Completer<GoogleMapController> _controller = Completer();

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

  void updateCameraPosition(CameraPosition cameraPosition) {
    this.properties['Bearing'] = SchemaDoubleProperty('Bearing', cameraPosition.bearing);
    this.properties['TargetLatitude'] = SchemaDoubleProperty('TargetLatitude', cameraPosition.target.latitude);
    this.properties['TargetLongitude'] = SchemaDoubleProperty('TargetLongitude', cameraPosition.target.longitude);
    this.properties['Tilt'] = SchemaDoubleProperty('Tilt', cameraPosition.tilt);
    this.properties['Zoom'] = SchemaDoubleProperty('Zoom', cameraPosition.zoom);
  }

  Future<void> _updateCameraPosition() async {
    updateMarkers();

    final GoogleMapController controller = await _controller.future;
    print('kek');
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: this.properties['Bearing'].value,
        target: this.latitudeLongitude,
        tilt: this.properties['Tilt'].value,
        zoom: this.properties['Zoom'].value,
      )
    ));
  }

  void updateMarkers() {
    if (_markers == null) _markers = { marker };
    _markers.clear();
    _markers.add(marker);
  }

  Marker get marker => Marker(
    position: latitudeLongitude,
    markerId: MarkerId('${UniqueKey()}'),
    icon: BitmapDescriptor.defaultMarker,
  );

  Set<Marker> _markers;

  UniqueKey mapKey = UniqueKey();

  @override
  Widget toWidget({ bool isPlayMode }) {

    return Container(
      key: mapKey,
      width: this.size.dx,
      height: this.size.dy,
      child: GoogleMap(
        mapType: MapType.normal,
        zoomControlsEnabled: false,
        zoomGesturesEnabled: false,
        tiltGesturesEnabled: false,
        scrollGesturesEnabled: false,
        rotateGesturesEnabled: false,
        markers: _markers,
        onTap: (_) {
          // Иначе ноду кликом не выбрать т.к. встроенные в библиотеку детекторы перебивают начисто все наши onTap
          parentSpawner.userActions.selectNodeForEdit(this);
        },
        initialCameraPosition: CameraPosition(
          bearing: this.properties['Bearing'].value,
          target: LatLng(this.properties['TargetLatitude'].value, this.properties['TargetLongitude'].value),
          tilt: this.properties['Tilt'].value,
          zoom: this.properties['Zoom'].value
        ),
        onCameraMove: this.updateCameraPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  LatLng get latitudeLongitude => LatLng(this.properties['TargetLatitude'].value, this.properties['TargetLongitude'].value);

  @override
  Widget toWidgetWithReplacedData({bool isPlayMode, String data, MyTheme theme = null}) {
    // TODO: implement toWidgetWithReplacedData
    return this.toWidget(isPlayMode: isPlayMode);
  }

  @override
  Widget toEditProps(wrapInRootProps, Function(SchemaNodeProperty, [bool, dynamic]) changePropertyTo) {
    Widget renderInput({String name, String defaultValue, Function onChanged}) {
      return Row(children: [
        Text(
          name,
          style: MyTextStyle.regularCaption,
        ),
        Expanded(child: Container()),
        Container(
          width: 170,
          child: MyTextField(
            defaultValue: defaultValue,
            onChanged: onChanged
          ),
        )
      ]);
    }

    return wrapInRootProps(
      Column(children: [
        ColumnDivider(name: 'Data'),
        renderInput(
          name: 'Latitude',
          defaultValue: properties['TargetLatitude'].value.toString(),
          onChanged: (String value) {
            changePropertyTo(SchemaDoubleProperty('TargetLatitude', double.parse(value)));
            _updateCameraPosition();
          },
        ),
        SizedBox(
          height: 15,
        ),
        renderInput(
          name: 'Longitude',
          defaultValue: properties['TargetLongitude'].value.toString(),
          onChanged: (String value) {
            changePropertyTo(SchemaDoubleProperty('TargetLongitude', double.parse(value)));
            _updateCameraPosition();
          },
        ),
        SizedBox(
          height: 15,
        ),
        renderInput(
          name: 'Zoom',
          defaultValue: properties['Zoom'].value.toString(),
          onChanged: (String value) {
            changePropertyTo(SchemaDoubleProperty('Zoom', double.parse(value)));
            _updateCameraPosition();
          },
        ),
        SizedBox(
          height: 15,
        ),
        // EditPropsColor(
        //   currentTheme: parentSpawner.userActions.themeStore.currentTheme,
        //   properties: properties,
        //   changePropertyTo: (schemaNodeProperty, [bool, dynamic]) {
        //     changePropertyTo(schemaNodeProperty);
        //     this.updateMarkers();
        //   },
        //   propName: 'IconColor',
        // ),
      ]),
    );
  }
}
