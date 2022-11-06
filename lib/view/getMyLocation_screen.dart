import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class GetMyLocationPage extends StatefulWidget {
final  LatLng latLng;
  const GetMyLocationPage({Key? key, required this.latLng}) : super(key: key);

  @override
  State<GetMyLocationPage> createState() => _GetMyLocationPageState();
}

class _GetMyLocationPageState extends State<GetMyLocationPage> {
  final Completer<GoogleMapController> _mapController = Completer();
  final Set<Marker> markers = Set();

  @override
  void initState() {
    super.initState();
    // getMyLocation();
  }

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
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //   content: Row(
              //     children: [
              //       const Text(
              //         'To Navigate you, Tap on Marker then  ',
              //         style: TextStyle(color: Colors.white),
              //       ),
              //
              //       // RotatedBox(
              //       //     quarterTurns: 2,
              //       //     child: Icon(Icons.subdirectory_arrow_left,color: Colors.white),)
              //     ],
              //   ),
              //   duration: const Duration(milliseconds: 2500),
              //   backgroundColor: Colors.black,
              // ));
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
    // Position position = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.high);

// print('Addresssssssssssssss is $address');
//     List<Placemark> placemarks =
//     await placemarkFromCoordinates(latlang.latitude, latlang.longitude);
//     Placemark place = placemarks[0];
//     String addressname = '${place.locality} , ${place.administrativeArea}';
//     String street = ' ${place.street}';
//
//     print('address is $addressname');
//     print(
//         'locality is ${place.locality} , ${place.administrativeArea} ,  ${place.street} ');

    setState(() {
        markers.add(Marker(
          // This marker id can be anything that uniquely identifies each marker.
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
