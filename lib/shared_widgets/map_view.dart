import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatelessWidget {
  const MapView({Key key, this.theme, this.size, this.properties})
      : super(key: key);

  final Map<String, SchemaNodeProperty> properties;
  final Offset size;
  final MyTheme theme;

  Marker get marker => Marker(
        position: LatLng(this.properties['TargetLatitude'].value,
            this.properties['TargetLongitude'].value),
        markerId: MarkerId('${UniqueKey()}'),
        icon: BitmapDescriptor.defaultMarker,
      );

  Set<Marker> get _markers {
    final markers = Set<Marker>();

    markers.add(Marker(
      position: LatLng(this.properties['TargetLatitude'].value,
          this.properties['TargetLongitude'].value),
      markerId: MarkerId('${UniqueKey()}'),
      icon: BitmapDescriptor.defaultMarker,
    ));

    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.dx,
      height: size.dy,
      child: GoogleMap(
        mapType: MapType.normal,
        zoomControlsEnabled: false,
        zoomGesturesEnabled: false,
        tiltGesturesEnabled: true,
        scrollGesturesEnabled: true,
        rotateGesturesEnabled: true,
        markers: _markers,
        initialCameraPosition: CameraPosition(
            bearing: this.properties['Bearing'].value,
            target: LatLng(this.properties['TargetLatitude'].value,
                this.properties['TargetLongitude'].value),
            tilt: this.properties['Tilt'].value,
            zoom: this.properties['Zoom'].value),
      ),
    );
  }
}
