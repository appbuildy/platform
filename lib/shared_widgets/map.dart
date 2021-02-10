import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MapView extends StatefulWidget {
  const MapView({Key key, this.theme, this.size, this.properties})
      : super(key: key);

  final Map<String, SchemaNodeProperty> properties;
  final Offset size;
  final MyTheme theme;

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  MapboxMapController mapController;

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    setState(() {
      mapController = controller;
    });
  }

  void _onStyleLoadedCallback() {}

  @override
  Widget build(BuildContext context) {
    print('are you here bro?');

    return Container(
      width: 350,
      height: 350,
      child: MapboxMap(
        accessToken:
            'pk.eyJ1Ijoic2Vyam9iYXMiLCJhIjoiY2p5dngwNHR6MGY0OTNkbnlzcWY4MWh5MyJ9.s7Q3Ef_UCKH0p645fzKFOw',
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(
          target: LatLng(-33.852, 151.211),
          zoom: 5.0,
        ),
      ),
    );
  }
}
