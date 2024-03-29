import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:safarirally2023/services/firebase_services.dart';

class ContractorForms extends StatefulWidget {
  const ContractorForms({Key? key}) : super(key: key);

  @override
  State<ContractorForms> createState() => _ContractorFormsState();
}

class _ContractorFormsState extends State<ContractorForms> {

  late Timer _timer;

  final List _colors = [
    Colors.lightBlueAccent,
    Colors.lightGreenAccent,
    Colors.greenAccent
  ];
  int _currentColorIndex = 0;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

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
      const DropdownMenuItem(value: "Malewa", child: Text("Narasha")),
      const DropdownMenuItem(value: "Hell's Gate", child: Text("Hell's Gate")),
      const DropdownMenuItem(value: "Refuelling", child: Text("Refuelling")),
      const DropdownMenuItem(value: "Car Wash", child: Text("Car Wash")),
      const DropdownMenuItem(value: "Other", child: Text("Other")),
    ];
    return menuItems;
  }



  @override
  Widget build(BuildContext context) {

    String? area;
    int? vipToilets;
    int? regularToilets;
    int? disabledToilets;

    FirebaseServices services = FirebaseServices();
    String? name;

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
                                "Contractor Deployment Form",
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
                          labelText: "Deployment Area",
                          prefixIcon: const Icon(Icons.category),
                        ),
                        value: area,
                        items: dropDownItems,
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a deployment area';
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
                      TextFormField(
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
                            labelText: "Number of VIP toilets delivered",
                            prefixIcon: const Icon(Icons.spa_sharp)
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the number of VIP toilets';
                          }
                          // check if the value is an integer
                          if (int.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          vipToilets = int.parse(value!);
                        },
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
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
                            labelText: "Number of Regular Toilets Delivered",
                            prefixIcon: const Icon(Icons.wc_sharp)
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the number of Regular toilets';
                          }
                          // check if the value is an integer
                          if (int.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          regularToilets = int.parse(value!);
                        },
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
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
                            labelText: "Number of Disabled toilets delivered",
                            prefixIcon: const Icon(Icons.wheelchair_pickup)
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the number of Disabled toilets';
                          }
                          // check if the value is an integer
                          if (int.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          disabledToilets = int.parse(value!);
                        },
                      ),
                      const SizedBox(height: 30,),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor
                          ),
                          onPressed: () {
                            if(_formKey.currentState!.validate()){
                              EasyLoading.show(status: "Waiting", indicator: const CircularProgressIndicator());
                              FirebaseFirestore.instance.collection("deployment").add({
                                "Stage": area,
                                "Number of Vip Toilets": vipToilets,
                                "Number of Regular Toilets": regularToilets,
                                "Number of Disabled Toilets": disabledToilets,
                                "timestamp": DateTime.now(),
                                "Submitted By": name
                              });
                              _formKey.currentState?.reset();
                              EasyLoading.showSuccess("Successfully added");
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