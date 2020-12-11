import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaDoubleProperty.dart';
import 'package:flutter_app/features/schemaNodes/schemaAction.dart';
import 'package:flutter_app/shared_widgets/icon.dart' as Shared;
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'SchemaNodeSpawner.dart';
import 'implementations.dart';

// class MapSample extends StatefulWidget {
//   @override
//   State<MapSample> createState() => MapSampleState();
// }
//
// class MapSampleState extends State<MapSample> {
//   Completer<GoogleMapController> _controller = Completer();
//
//   static final CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );
//
//   static final CameraPosition _kLake = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(37.43296265331129, -122.08832357078792),
//       tilt: 59.440717697143555,
//       zoom: 19.151926040649414);
//
//   @override
//   Widget build(BuildContext context) {
//     return GoogleMap(
//       mapType: MapType.normal,
//       initialCameraPosition: _kGooglePlex,
//       onMapCreated: (GoogleMapController controller) {
//         _controller.complete(controller);
//       },
//     );
//
//     return Scaffold(
//       body: GoogleMap(
//         mapType: MapType.normal,
//         initialCameraPosition: _kGooglePlex,
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: _goToTheLake,
//         label: Text('To the lake!'),
//         icon: Icon(Icons.directions_boat),
//       ),
//     );
//   }
//
//   Future<void> _goToTheLake() async {
//     final GoogleMapController controller = await _controller.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//   }
// }

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

  void changeCameraPosition(CameraPosition cameraPosition) {
    this.properties['Bearing'] = SchemaDoubleProperty('Bearing', cameraPosition.bearing);
    this.properties['TargetLatitude'] = SchemaDoubleProperty('TargetLatitude', cameraPosition.target.latitude);
    this.properties['TargetLongitude'] = SchemaDoubleProperty('TargetLongitude', cameraPosition.target.longitude);
    this.properties['Tilt'] = SchemaDoubleProperty('Tilt', cameraPosition.tilt);
    this.properties['Zoom'] = SchemaDoubleProperty('Zoom', cameraPosition.zoom);
  }

  UniqueKey uniqueKey = UniqueKey();

  @override
  Widget toWidget({ bool isPlayMode }) {
    return Container(
      key: uniqueKey,
      width: this.size.dx,
      height: this.size.dy,
      child: IgnorePointer(
        ignoring: true,
        child: AbsorbPointer(
          absorbing: true,
          child: GoogleMap(
            mapType: MapType.normal,
            zoomControlsEnabled: false,
            zoomGesturesEnabled: false,
            tiltGesturesEnabled: false,
            scrollGesturesEnabled: false,
            rotateGesturesEnabled: false,
            initialCameraPosition: CameraPosition(
              bearing: this.properties['Bearing'].value,
              target: LatLng(this.properties['TargetLatitude'].value, this.properties['TargetLongitude'].value),
              tilt: this.properties['Tilt'].value,
              zoom: this.properties['Zoom'].value
            ),
            onCameraMove: this.changeCameraPosition,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget toWidgetWithReplacedData({bool isPlayMode, String data}) {
    // TODO: implement toWidgetWithReplacedData
    return this.toWidget(isPlayMode: isPlayMode);
  }

  @override
  Widget toEditProps(wrapInRootProps, Function(SchemaNodeProperty, [bool, dynamic]) changePropertyTo) {
    return wrapInRootProps(
      Column(children: [
        Container(),
      ])
    );
  }
}
