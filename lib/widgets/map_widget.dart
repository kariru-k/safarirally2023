
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';
import 'package:safarirally2023/services/firebase_services.dart';

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
    String? toiletType;


    setState(() {
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
        Map<String, dynamic>? toilets = snapshot.data!.docs[0]['Toilets'];
        List<dynamic>? litterAreas = snapshot.data!.docs[0]['Littered Areas'];
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

        if(litterAreas != null){
          for(var area in litterAreas){
            markers.add(Marker(
                markerId: const MarkerId("Littered Area"),
                position: LatLng(area["position"]!.latitude, area["position"]!.longitude),
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
                infoWindow: const InfoWindow(title: "Littered Area"),
                onTap: (){
                  showCupertinoDialog(
                      context: context,
                      builder: (BuildContext context){
                        return CupertinoAlertDialog(
                          title: const Text("Remove Littered Area from stage"),
                          content: const Text("Is this location now clean enough?"),
                          actions: [
                            TextButton(
                                onPressed: (){
                                  EasyLoading.show(status: "Updating map...");
                                  firebaseServices.deleteLitteredArea(
                                      documentId: widget.stage,
                                      timestamp: area["submittedAt"],
                                      location: area["position"]
                                  ).then((value){
                                    EasyLoading.showSuccess("Successfully updated", duration: const Duration(seconds: 3), dismissOnTap: true);
                                  });
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "OK",
                                  style: TextStyle(color: Theme.of(context).primaryColor),
                                )
                            ),
                            TextButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Go Back",
                                  style: TextStyle(color: Theme.of(context).primaryColor),
                                )
                            )
                          ],
                        );
                      }
                  );
                }
            ));
          }
        }

        if (toilets != null){
          for(var type in toilets.keys){
            for(var toilet in toilets[type]){
              markers.add(
                  Marker(
                    markerId: MarkerId(type),
                    position: LatLng(toilet["position"]!.latitude, toilet["position"]!.longitude),
                    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
                    infoWindow: InfoWindow(title: type),
                    onTap: () {
                      showCupertinoDialog(
                          context: context,
                          builder: (BuildContext context){
                            return CupertinoAlertDialog(
                              title: const Text("Remove Toilet from site"),
                              content: const Text("Are you sure you want to remove this location as a toilet site?"),
                              actions: [
                                TextButton(
                                    onPressed: (){
                                      EasyLoading.show(status: "Updating map...");
                                      firebaseServices.deleteToiletLocation(
                                        documentId: widget.stage,
                                        type: type,
                                        timestamp: toilet["submittedAt"],
                                        location: toilet["position"]
                                      ).then((value){
                                        EasyLoading.showSuccess("Successfully updated", duration: const Duration(seconds: 3), dismissOnTap: true);
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "OK",
                                      style: TextStyle(color: Theme.of(context).primaryColor),
                                    )
                                ),
                                TextButton(
                                    onPressed: (){
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Go Back",
                                      style: TextStyle(color: Theme.of(context).primaryColor),
                                    )
                                )
                              ],
                            );
                          }
                      );
                    }
              ));
            }
          }
        }


        showMyDialog({required context}){
          showCupertinoDialog(
              context: context,
              builder: (BuildContext context){
                return CupertinoAlertDialog(
                  title: const Text("Confirm Presence of a Toilet"),
                  content: const Text("Are you sure you want to add this location as a toilet site?"),
                  actions: [
                    TextButton(
                        onPressed: (){
                          EasyLoading.show(status: "Updating map...");
                          firebaseServices.updateToiletLocation(widget.stage, toiletType, GeoPoint(locationData.latitude as double, locationData.longitude as double)).then((value){
                            EasyLoading.showSuccess("Successfully updated", duration: const Duration(seconds: 3), dismissOnTap: true);
                          });
                          Navigator.pop(context);
                        },
                        child: Text(
                          "OK",
                          style: TextStyle(color: Theme.of(context).primaryColor),
                        )
                    ),
                    TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Go Back",
                          style: TextStyle(color: Theme.of(context).primaryColor),
                        )
                    )
                  ],
                );
              }
          );
        }

        confirmLitterArea({required context}){
          showCupertinoDialog(
              context: context,
              builder: (BuildContext context){
                return CupertinoAlertDialog(
                  title: const Text("Confirm Presence of a Litter Area"),
                  content: const Text("Are you sure you want to add this location as a Littered Area?"),
                  actions: [
                    TextButton(
                        onPressed: (){
                          EasyLoading.show(status: "Updating map...");
                          firebaseServices.updateLitterLocation(widget.stage, GeoPoint(locationData.latitude as double, locationData.longitude as double)).then((value){
                            EasyLoading.showSuccess("Successfully updated", duration: const Duration(seconds: 3), dismissOnTap: true);
                          });
                          Navigator.pop(context);
                        },
                        child: Text(
                          "OK",
                          style: TextStyle(color: Theme.of(context).primaryColor),
                        )
                    ),
                    TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Go Back",
                          style: TextStyle(color: Theme.of(context).primaryColor),
                        )
                    )
                  ],
                );
              }
          );
        }

        Future getToiletType(context){
          return showDialog(
              context: context,
              builder: (BuildContext context){
                return Dialog(
                  child: SizedBox(
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Choose Toilet Type", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                        const SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GroupButton(
                            isRadio: true,
                            buttons: const ['Regular', 'VIP', 'Disabled'],
                            onSelected: (i, selected, _){
                              setState(() {
                                toiletType = i;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 10,),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlueAccent,
                            elevation: 0,
                          ),
                          onPressed: () {
                            showMyDialog(context: context);
                          },
                          child: const Text(
                            "Mark Toilet",
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
          );
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
                        zoom: 11.85
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
                        child: Image.asset('images/marker.png', height: 40, color: Colors.yellowAccent,),
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
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(context).primaryColor,
                                      elevation: 0,
                                    ),
                                    onPressed: () {
                                      getToiletType(context);
                                    },
                                    child: const Text(
                                      "Mark Toilet Location",
                                      style: TextStyle(
                                        color: Colors.white
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15,),
                                  const Flexible(child: Text("Mark each toilet at a time"))
                                ],
                              ),
                              const SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(context).primaryColor,
                                      elevation: 0,
                                    ),
                                    onPressed: () {
                                      confirmLitterArea(context: context);
                                    },
                                    child: const Text(
                                      "Mark Littered Area",
                                      style: TextStyle(
                                        color: Colors.white
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 22,),
                                  const Flexible(child: Text("Mark area with garbage buildup"))
                                ],
                              ),
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
