import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:safarirally2023/services/firebase_services.dart';
import 'package:widget_zoom/widget_zoom.dart';
import '../providers/auth_provider.dart';


class ReportingTool extends StatefulWidget {
  static const String id = "reporting-tool";
  const ReportingTool({Key? key}) : super(key: key);

  @override
  State<ReportingTool> createState() => _ReportingToolState();
}

class _ReportingToolState extends State<ReportingTool> {
  late Timer _timer;
  File? _image;
  final List _colors = [
    Colors.lightBlueAccent,
    Colors.lightGreenAccent,
    Colors.greenAccent
  ];
  int _currentColorIndex = 0;
  final _formKey = GlobalKey<FormState>();
  final _comment = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;


  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  // Start the timer
  void _startTimer() {
    // Set up a periodic timer that triggers the color change every 3 seconds
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _currentColorIndex = (_currentColorIndex + 1) % _colors.length;
      });
    });
  }

  // Cancel the timer when the widget is disposed
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  List<DropdownMenuItem<String>> get dropDownItems{
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Kasarani", child: Text("Kasarani")),
      const DropdownMenuItem(value: "Service Park", child: Text("Service Park")),
      const DropdownMenuItem(value: "Shakedown", child: Text("Shakedown")),
      const DropdownMenuItem(value: "Loldia", child: Text("Loldia")),
      const DropdownMenuItem(value: "Kedong", child: Text("Kedong")),
      const DropdownMenuItem(value: "Geothermal", child: Text("Geothermal")),
      const DropdownMenuItem(value: "Soysambu", child: Text("Soysambu")),
      const DropdownMenuItem(value: "Elementaita", child: Text("Elementaita")),
      const DropdownMenuItem(value: "Sleeping Warrior", child: Text("Sleeping Warrior")),
      const DropdownMenuItem(value: "Oserian", child: Text("Oserian")),
      const DropdownMenuItem(value: "Narasha", child: Text("Narasha")),
      const DropdownMenuItem(value: "Hell's Gate", child: Text("Hell's Gate")),
      const DropdownMenuItem(value: "Refuelling", child: Text("Refuelling")),
      const DropdownMenuItem(value: "Car Wash", child: Text("Car Wash")),
      const DropdownMenuItem(value: "Other", child: Text("Other")),
    ];
    return menuItems;
  }



  @override
  Widget build(BuildContext context) {

    final authData = Provider.of<AuthProvider>(context);
    FirebaseServices services = FirebaseServices();
    String? name;
    String? area;

    services.getUserName().then((value){
      name = value["name"];
    });


    return SafeArea(
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                _colors[_currentColorIndex], // Use the current color
                _colors[(_currentColorIndex + 1) % _colors.length], // Use the next color in the list
              ],
            )
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
          ),
          backgroundColor: Colors.transparent,
          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "images/safari_rally_logo.png",
                              height: 80,
                              width: 250,
                            ),
                            const SizedBox(height: 10,),
                            const FittedBox(
                              child: Text(
                                "Real Time Reporting Tool",
                                style: TextStyle(
                                    fontFamily: "Anton",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: InkWell(
                          onTap: (){
                            authData.getImageFromCamera().then((image){
                              setState(() {
                                _image = image;
                              });
                              if(image != null){
                                authData.picture = true;
                              }
                            });
                          },
                          child: SizedBox(
                            height: 250,
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4.0),
                                child: _image == null ? const Center(
                                    child: Text(
                                      "Take a Picture by pressing this button",
                                      style: TextStyle(
                                          color: Colors.grey
                                      ),
                                    )
                                ) : WidgetZoom(
                                  zoomWidget: Image.file(_image!, fit: BoxFit.fill,),
                                  heroAnimationTag: "Image",
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(),
                          errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                style: BorderStyle.solid,
                                width: 2,
                                color: Colors.redAccent
                            ),
                          ),
                          focusColor: Theme.of(context).primaryColor,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  width: 2,
                                  color: Colors.pinkAccent.shade700
                              )
                          ),
                          contentPadding: EdgeInsets.zero,
                          labelText: "Area of Concern",
                          prefixIcon: const Icon(Icons.category),
                        ),
                        value: area,
                        items: dropDownItems,
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a rally category';
                          }
                          setState(() {
                            area = value;
                          });
                          return null;
                        },
                        onChanged: (String? value) {
                          setState(() {
                            area = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20,),
                      Container(
                        color: Colors.white,
                        height: 200,
                        child: TextFormField(
                          controller: _comment,
                          maxLines: null,
                          expands: true,
                          textAlignVertical: TextAlignVertical.top,
                          keyboardType: TextInputType.multiline,
                          validator: (value){
                            if(value!.isEmpty){
                              return "You forgot to add a description of your report";
                            }
                            setState(() {
                              _comment.text = value;
                            });
                            return null;
                          },
                          decoration: InputDecoration(
                              fillColor: Colors.black,
                              enabledBorder: const OutlineInputBorder(),
                              errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    style: BorderStyle.solid,
                                    width: 2,
                                    color: Colors.redAccent
                                ),
                              ),
                              focusColor: Theme.of(context).primaryColor,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      width: 2,
                                      color: Colors.pinkAccent.shade700
                                  )
                              ),
                              labelText: "Describe the Issue/ Comment",
                              contentPadding: const EdgeInsets.all(10.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor
                          ),
                          onPressed: () {
                            if(_formKey.currentState!.validate()){
                              EasyLoading.show(status: "Waiting", indicator: const CircularProgressIndicator());
                              if(authData.picture == true){
                                services.uploadShopPicFile(authData.image!.path).then((url){
                                  if(url != null){
                                    services.addCommentReport(
                                      url: url,
                                      comment: _comment.text,
                                      submitter: name,
                                      area: area,
                                      location: GeoPoint(authData.userLatitude as double, authData.userLongitude as double)
                                    ).then((value){
                                      EasyLoading.showSuccess("Your report has been added successfully");
                                      Navigator.pop(context);
                                    });
                                  } else {
                                    EasyLoading.showError("Please add an Image for easier clarification");
                                  }
                                });
                              } else {
                                EasyLoading.showError("Please add an Image for easier clarification");
                              }
                            }
                          },
                          child: const Text(
                            "SUBMIT",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
