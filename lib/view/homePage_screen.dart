import 'package:addmylocation/view/getMyLocation_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:lottie/lottie.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 late LatLng currentPostion;
 bool showLoading = false;
 Future<LatLng> _getUserLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high).then((value) {
      setState(() {
        showLoading = true;
        currentPostion = LatLng(value.latitude, value.longitude);
      });
    });
    return currentPostion;
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome To\nGet My Location',
              textAlign: TextAlign.center,
              style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,

            ),),
            SizedBox(
              height: size.height*.05,
            ),
            SizedBox(
                height: size.height*.3,
                child: LottieBuilder.asset('assets/31374-map-marker.json')),
            SizedBox(
              height: size.height*.05,
            ),
            ElevatedButton(onPressed: () async {
              setState(() {
                showLoading=true;
              });
              if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
                // Use location.
                if(await Permission.location.status.isGranted){
                  _getUserLocation().then((value) {
                    
                    Navigator.push(context, MaterialPageRoute(builder: (context) => GetMyLocationPage(
                      latLng: currentPostion,
                    ),)).then((value) {
                      setState(() {
                        showLoading = false;
                      });

                    });
                  });
                  debugPrint(currentPostion.toString());

                }
                Map<Permission, PermissionStatus> status = await [ Permission. location, ].request();
              }else{
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Row(
                    children: const [
                      Text(
                        'You should enable Location Permission',
                        style: TextStyle(color: Colors.white),
                      ),

                      // RotatedBox(
                      //     quarterTurns: 2,
                      //     child: Icon(Icons.subdirectory_arrow_left,color: Colors.white),)
                    ],
                  ),
                  duration: const Duration(milliseconds: 2500),
                  backgroundColor: Colors.black,
                ));
                openAppSettings();

              }

            },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDAD7CD)
                ),
                child: const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text('Get My Location',style: TextStyle(
                fontSize: 20,fontWeight: FontWeight.bold,color: Color(0xFF344E41)
              ),),
            )),
            SizedBox(
              height: size.height*.025,
            ),
            Visibility(
                visible: showLoading,
                child: Center(
              child: CircularProgressIndicator(),
            ))
          ],
        ),
      ),
    );
  }
}
