import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:safarirally2023/screens/marshall_form_screens.dart';

import '../services/firebase_services.dart';

class NoiseTestForm extends StatefulWidget {
  const NoiseTestForm({Key? key}) : super(key: key);

  @override
  State<NoiseTestForm> createState() => _NoiseTestFormState();
}

class _NoiseTestFormState extends State<NoiseTestForm> {
  final List _colors = [
    Colors.lightBlueAccent,
    Colors.lightGreenAccent,
    Colors.greenAccent
  ];
  int _currentColorIndex = 0;
  late Timer _timer;
  FirebaseServices services = FirebaseServices();
  final _formKey = GlobalKey<FormState>();
  Icon? icon;
  final _driverName = TextEditingController();
  final _coDriverName = TextEditingController();
  final _carMake = TextEditingController();
  final _carModel = TextEditingController();
  final _halfMeterMax = TextEditingController(text: "0.0");
  final _halfMeterMin = TextEditingController(text: "0.0");
  final _halfMeterAverage = TextEditingController(text: "0.0");
  final _twoMeterMax = TextEditingController(text: "0.0");
  final _twoMeterMin = TextEditingController(text: "0.0");
  final _twoMeterAverage = TextEditingController(text: "0.0");
  final _fiveMeterMax = TextEditingController(text: "0.0");
  final _fiveMeterMin = TextEditingController(text: "0.0");
  final _fiveMeterAverage = TextEditingController(text: "0.0");
  double halfmax = 0.0;
  double halfmin = 0.0;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _halfMeterMax.addListener(_onHalfAverageCalculator);
    _halfMeterMin.addListener(_onHalfAverageCalculator);
    _twoMeterMax.addListener(_onTwoAverageCalculator);
    _twoMeterMin.addListener(_onTwoAverageCalculator);
    _fiveMeterMax.addListener(_onFiveAverageCalculator);
    _fiveMeterMin.addListener(_onFiveAverageCalculator);
  }

  _onHalfAverageCalculator() {
    setState(() {
      _halfMeterAverage.text = ((double.parse(_halfMeterMax.text) + double.parse(_halfMeterMin.text)) / 2).toString();

    });
  }

  _onTwoAverageCalculator() {
    setState(() {
      _twoMeterAverage.text = ((double.parse(_twoMeterMax.text) + double.parse(_twoMeterMin.text)) / 2).toString();

    });
  }

  _onFiveAverageCalculator() {
    setState(() {
      _fiveMeterAverage.text = ((double.parse(_fiveMeterMax.text) + double.parse(_fiveMeterMin.text)) / 2).toString();
    });
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

  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "RC1 Rally1", child: Text("RC1 Rally1")),
      const DropdownMenuItem(value: "RC2 Rally2", child: Text("RC2 Rally2")),
      const DropdownMenuItem(value: "RC3 Rally 3", child: Text("RC3 Rally 3")),
      const DropdownMenuItem(value: "NAT NR4", child: Text("NAT NR4")),
      const DropdownMenuItem(value: "NAT N4", child: Text("NAT N4")),
      const DropdownMenuItem(value: "NAT NR2", child: Text("NAT NR2")),
    ];
    return menuItems;
  }






  @override
  Widget build(BuildContext context) {
    String? rallyCategory;

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
                                "Noise Test Form",
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
                      TextFormField(
                        controller: _driverName,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value){
                          if(value!.isEmpty){
                            return "Enter Driver's name";
                          }
                          setState(() {
                            _driverName.text = value;
                          });
                          return null;
                        },
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
                            labelText: "Driver Name",
                            prefixIcon: const Icon(Icons.person)
                        ),
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        controller: _coDriverName,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Co-Driver Name";
                          }
                          setState(() {
                            _coDriverName.text = value;
                          });
                          return null;
                        },
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
                            labelText: "Co-Driver Name",
                            prefixIcon: const Icon(Icons.person_3_sharp),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        controller: _carMake,
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
                            labelText: "Car Make",
                            prefixIcon: const Icon(Icons.car_repair_outlined),
                          ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the Car Make';
                          }
                          setState(() {
                            _carMake.text = value;
                          });
                          return null;
                        },
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        controller: _carModel,
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
                            labelText: "Car Model",
                            prefixIcon: const Icon(Icons.car_repair_outlined),
                          ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the Car Model';
                          }
                          setState(() {
                            _carModel.text = value;
                          });
                          return null;
                        },
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
                          labelText: "Rally Category",
                          prefixIcon: const Icon(Icons.category),
                        ),
                        value: rallyCategory,
                        items: dropdownItems,
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a rally category';
                          }
                          setState(() {
                            rallyCategory = value;
                          });
                          return null;
                        },
                        onChanged: (String? value) {
                          setState(() {
                            rallyCategory = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Flexible(child: Text("0.5m Sound Test Values(dB)")),
                          const SizedBox(width: 10,),
                          Flexible(
                              child: TextFormField(
                                controller: _halfMeterMax,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please enter a valid sound reading';
                                  }
                                  setState(() {
                                    _halfMeterMax.text = value;
                                  });
                                  return null;
                                },
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
                                  contentPadding: const EdgeInsets.all(6.0),
                                  label: const Text("Max", textAlign: TextAlign.center,),
                              ),

                          )),
                          const SizedBox(width: 10,),
                          Flexible(
                              child: TextFormField(
                                controller: _halfMeterMin,
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
                                  contentPadding: const EdgeInsets.all(6.0),
                                  label: const Text("Min", textAlign: TextAlign.center,),
                              ),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please enter a valid sound reading';
                                  }
                                  setState(() {
                                    _halfMeterMin.text = value;
                                  });
                                  return null;
                                },
                          )),
                          const SizedBox(width: 10,),
                          Flexible(
                              child: TextFormField(
                                enabled: false,
                                controller: _halfMeterAverage,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please enter a valid sound reading';
                                  }
                                  return null;
                                },
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
                                  contentPadding: const EdgeInsets.all(6.0),
                                  label: const Text("Average", textAlign: TextAlign.center,),
                                ),
                          ))
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Flexible(child: Text("2m Sound Test Values(dB)")),
                          const SizedBox(width: 10,),
                          Flexible(
                              child: TextFormField(
                                controller: _twoMeterMax,
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please enter a valid sound reading';
                                  }
                                  setState(() {
                                    _twoMeterMax.text = value;
                                  });
                                  return null;
                                },
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
                                  contentPadding: const EdgeInsets.all(6.0),
                                  label: const Text("Max", textAlign: TextAlign.center,),
                                ),

                              )),
                          const SizedBox(width: 10,),
                          Flexible(
                              child: TextFormField(
                                controller: _twoMeterMin,
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please enter a valid sound reading';
                                  }
                                  setState(() {
                                    _twoMeterMin.text = value;
                                  });
                                  return null;
                                },
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
                                  contentPadding: const EdgeInsets.all(6.0),
                                  label: const Text("Min", textAlign: TextAlign.center,),
                                ),
                              )),
                          const SizedBox(width: 10,),
                          Flexible(
                              child: TextFormField(
                                enabled: false,
                                controller: _twoMeterAverage,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please enter a valid sound reading';
                                  }
                                  setState(() {
                                    _twoMeterAverage.text = value;
                                  });
                                  return null;
                                },
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
                                  contentPadding: const EdgeInsets.all(6.0),
                                  label: const Text("Average", textAlign: TextAlign.center,),
                                ),
                              ))
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Flexible(child: Text("5m Sound Test Values(dB)")),
                          const SizedBox(width: 10,),
                          Flexible(
                              child: TextFormField(
                                controller: _fiveMeterMax,
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please enter a valid sound reading';
                                  }
                                  setState(() {
                                    _fiveMeterMax.text = value;
                                  });
                                  return null;
                                },
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
                                  contentPadding: const EdgeInsets.all(6.0),
                                  label: const Text("Max", textAlign: TextAlign.center,),
                                ),

                              )),
                          const SizedBox(width: 10,),
                          Flexible(
                              child: TextFormField(
                                controller: _fiveMeterMin,
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please enter a valid sound reading';
                                  }
                                  setState(() {
                                    _fiveMeterMin.text = value;
                                  });
                                  return null;
                                },
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
                                  contentPadding: const EdgeInsets.all(6.0),
                                  label: const Text("Min", textAlign: TextAlign.center,),
                                ),
                              )
                          ),
                          const SizedBox(width: 10,),
                          Flexible(
                              child: TextFormField(
                                controller: _fiveMeterAverage,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please enter a valid sound reading';
                                  }
                                  setState(() {
                                    _fiveMeterAverage.text = value;
                                  });
                                  return null;
                                },
                                enabled: false,
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
                                  contentPadding: const EdgeInsets.all(6.0),
                                  label: const Text("Average", textAlign: TextAlign.center,),
                                ),
                              ))
                        ],
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
                              EasyLoading.show(status: "Updating");
                              services.addNoiseTestData({
                                "Driver": _driverName.text,
                                "Co-Driver": _coDriverName.text,
                                "Car Make": _carMake.text,
                                "Car Model": _carModel.text,
                                "Category": rallyCategory,
                                "0.5 meters": {
                                  "max": _halfMeterMax.text,
                                  "min": _halfMeterMin.text,
                                  "average": _halfMeterAverage.text,
                                  "compliance": double.parse(_halfMeterAverage.text) < 108.0 ? "Yes" : "No"
                                },
                                "2 meters": {
                                  "max": _halfMeterMax.text,
                                  "min": _halfMeterMin.text,
                                  "average": _halfMeterAverage.text,
                                  "compliance": double.parse(_halfMeterAverage.text) < 96.0 ? "Yes" : "No"
                                },
                                "5 meters": {
                                  "max": _halfMeterMax.text,
                                  "min": _halfMeterMin.text,
                                  "average": _halfMeterAverage.text,
                                  "compliance": double.parse(_halfMeterAverage.text) < 84.0 ? "Yes" : "No"
                                }
                              }).then((value){
                                EasyLoading.showSuccess("Successfully added data", duration: const Duration(seconds: 3));
                                PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                                  context,
                                  screen: const MarshallForms(),
                                  withNavBar: false,
                                  settings: const RouteSettings(name: MarshallForms.id),
                                );
                              });
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
