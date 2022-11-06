import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetMyLocationPage extends StatefulWidget {
  final LatLng latLng;

  const GetMyLocationPage({Key? key, required this.latLng}) : super(key: key);

  @override
  State<GetMyLocationPage> createState() => _GetMyLocationPageState();
}

class _GetMyLocationPageState extends State<GetMyLocationPage> {
  final Completer<GoogleMapController> _mapController = Completer();
  final Set<Marker> markers = Set();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: GoogleMap(
            onTap: (latlng) {
              _onAddMarkerButtonPressed(latlng);
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            compassEnabled: true,
            scrollGesturesEnabled: true,
            mapToolbarEnabled: true,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            tiltGesturesEnabled: false,
            trafficEnabled: true,
            liteModeEnabled: false,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              _mapController.complete(controller);
            },
            markers: getmarkers(),
            initialCameraPosition: CameraPosition(
              target: widget.latLng,
              zoom: 16.0,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onAddMarkerButtonPressed(latlang) async {
    setState(() {
      markers.add(Marker(
        markerId: MarkerId(latlang.toString()),
        position: latlang,
        infoWindow: InfoWindow.noText,
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  Set<Marker> getmarkers() {
    return markers;
  }
}
