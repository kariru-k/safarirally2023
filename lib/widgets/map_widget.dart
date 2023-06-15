
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:safarirally2023/services/firebase_services.dart';

import '../providers/auth_provider.dart';
import '../providers/location_provider.dart';

class RallyStageMap extends StatefulWidget {
  static const String id = "rally-stage-screen";
  const RallyStageMap({Key? key, required this.stage}) : super(key: key);
  final String? stage;

  @override
  State<RallyStageMap> createState() => _RallyStageMapState();
}

class _RallyStageMapState extends State<RallyStageMap> {
  FirebaseServices firebaseServices = FirebaseServices();


  @override
  Widget build(BuildContext context) {

    final LocationProvider locationData = Provider.of<LocationProvider>(context);
    final authData = Provider.of<AuthProvider>(context);
    late LatLng currentLocation;


    setState(() {
      currentLocation = LatLng(authData.userLatitude as double, authData.userLongitude as double);
    });

    void onCreated(GoogleMapController controller) {
      setState(() {
      });
    }

    return StreamBuilder<QuerySnapshot>(
      stream: firebaseServices.getMapDetails(widget.stage),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if(!snapshot.hasData) {
          return const Center(
            child: SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator()),
          );
        }

        GeoPoint start = snapshot.data!.docs[0]['start'];
        GeoPoint finish = snapshot.data!.docs[0]['finish'];
        Map<String, dynamic>? spectatorZones = snapshot.data!.docs[0]['Spectator Zones'];
        Set<Marker> markers = {
          Marker(
              markerId: const MarkerId("Start"),
              position: LatLng(start.latitude, start.longitude),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
              infoWindow: const InfoWindow(title: "Start")
          ),
          Marker(
              markerId: const MarkerId("Finish"),
              position: LatLng(finish.latitude, finish.longitude),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
              infoWindow: const InfoWindow(title: "Finish")
          ),
        };

        if(spectatorZones != null){
          for(var zone in spectatorZones.keys){
            markers.add(Marker(
                markerId: MarkerId(zone),
                position: LatLng(spectatorZones[zone]!.latitude, spectatorZones[zone]!.longitude),
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
                infoWindow: InfoWindow(title: zone)
            ));
          }
        }

        return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
            ),
            body: SafeArea(
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: LatLng(start.latitude, start.longitude),
                        zoom: 15
                    ),
                    zoomControlsEnabled: true,
                    minMaxZoomPreference: const MinMaxZoomPreference(1.5, 500),
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    mapType: MapType.satellite,
                    markers: markers,
                    mapToolbarEnabled: true,
                    onCameraMove: (CameraPosition position) {
                      locationData.onCameraMove(position);
                    },
                    onMapCreated: onCreated,
                  ),
                  Center(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 40),
                        child: Image.asset('images/marker.png'),
                      )
                  ),
                  const Center(
                      child: SpinKitPulse(
                          color: Colors.black,
                          size: 50.0
                      )
                  ),
                  Positioned(
                    bottom: 0.0,
                    child: Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: const Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            ],
                          ),
                        )
                    ),
                  )
                ],
              ),
            )
        );
      }
    );
  }
}
