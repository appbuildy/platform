import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaDoubleProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaIconProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaMyThemePropProperty.dart';
import 'package:flutter_app/features/schemaNodes/schemaAction.dart';
import 'package:flutter_app/shared_widgets/icon.dart' as Shared;
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_app/ui/ColumnDivider.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MyTextField.dart';
import 'package:flutter_app/ui/SelectIconList.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'SchemaNodeSpawner.dart';
import 'common/EditPropsColor.dart';
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
          'Icon': SchemaIconProperty('Icon', FontAwesomeIcons.mapMarkerAlt),
          'IconColor': SchemaMyThemePropProperty('IconColor', parent.userActions.currentTheme.primary),
        };

    this.setBitmapDescriptor();
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

  Future<void> _goToLatLng(LatLng latitudeLongitude) async {
    updateMarkers();

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: this.properties['Bearing'].value,
        target: latitudeLongitude,
        tilt: this.properties['Tilt'].value,
        zoom: this.properties['Zoom'].value,
      )
    ));
  }

  GlobalKey mapKey = GlobalKey();

  Marker get marker => Marker(
    position: latitudeLongitude,
    markerId: MarkerId('${UniqueKey()}'),
    //icon: BitmapDescriptor.defaultMarker,
    icon: _bitmapDescriptor == null
      ? BitmapDescriptor.defaultMarker
      : _bitmapDescriptor,
  );

  void updateMarkers() {
    _markers.clear();
    _markers.add(marker);
  }

  Set<Marker> _markers;

  BitmapDescriptor _bitmapDescriptor;

  void setBitmapDescriptor([IconData newIcon]) async {
    IconData icon = newIcon == null ? this.properties['Icon'].value : newIcon;

    if (icon == null) return;

    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder);

    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    textPainter.text = TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          inherit: false,
          letterSpacing: 0.0,
          fontSize: 48.0,
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
          color: (this.properties['IconColor'].value as MyThemeProp).color,
        )
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(0.0, 0.0));

    final picture = pictureRecorder.endRecording();
    final image = await picture.toImage(48, 48);
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);

    this._bitmapDescriptor = BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());

    this._markers = { marker };

    this.parentSpawner.userActions.rerenderNode();
  }

  Uint8List snapshot;

  // void screenShot() async {
  //   RenderRepaintBoundary boundary = await mapKey.currentContext.findRenderObject();
  //   print('here');
  //   ui.Image image = await boundary.toImage();
  //   print('here2');
  //   ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  //   print('here3');
  //
  //   print(byteData);
  // }

  @override
  Widget toWidget({ bool isPlayMode }) {

    return RepaintBoundary(
      key: mapKey,
      child: Container(
        width: this.size.dx,
        height: this.size.dy,
        child: GoogleMap(
          mapType: MapType.normal,
          zoomControlsEnabled: false,
          zoomGesturesEnabled: false,
          tiltGesturesEnabled: false,
          scrollGesturesEnabled: false,
          rotateGesturesEnabled: false,
          markers: this._markers,
          initialCameraPosition: CameraPosition(
            bearing: this.properties['Bearing'].value,
            target: LatLng(this.properties['TargetLatitude'].value, this.properties['TargetLongitude'].value),
            tilt: this.properties['Tilt'].value,
            zoom: this.properties['Zoom'].value
          ),
          onCameraMove: this.updateCameraPosition,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            //screenShot();
          },
        ),
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
          Expanded(
            child: MyTextField(
                defaultValue: properties['TargetLatitude'].value.toString(),
                onChanged: (String value) {
                  changePropertyTo(SchemaDoubleProperty('TargetLatitude', double.parse(value)));
                  _goToLatLng(this.latitudeLongitude);
                }),
          )
        ]),
        Row(children: [
          Text(
            'Longitude',
            style: MyTextStyle.regularCaption,
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: MyTextField(
                defaultValue: properties['TargetLongitude'].value.toString(),
                onChanged: (String value) {
                  changePropertyTo(SchemaDoubleProperty('TargetLongitude', double.parse(value)));
                  _goToLatLng(this.latitudeLongitude);
                }),
          )
        ]),
        EditPropsColor(
          currentTheme: parentSpawner.userActions.themeStore.currentTheme,
          properties: properties,
          changePropertyTo: (schemaNodeProperty, [bool, dynamic]) {
            changePropertyTo(schemaNodeProperty);

            this.setBitmapDescriptor();
            this.updateMarkers();
          },
          propName: 'IconColor',
        ),
        SelectIconList(
            subListHeight: 470,
            selectedIcon: this.properties['Icon'].value,
            onChanged: (IconData icon) async {
              await setBitmapDescriptor(icon);
              updateMarkers();
              changePropertyTo(SchemaIconProperty('Icon', icon));
            })
      ]),
    );
  }
}
