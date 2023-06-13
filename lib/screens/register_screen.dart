import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const String id = "register-screen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final List _colors = [
    Colors.lightBlueAccent,
    Colors.lightGreenAccent,
    Colors.greenAccent
  ];
  int _currentColorIndex = 0;
  late Timer _timer;
  Icon? icon;
  bool _visible = false;
  final _formKey = GlobalKey<FormState>();
  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _confirmpasswordTextController = TextEditingController();

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



  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthProvider>(context);

    scaffoldMessage(message){
      return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(message)
          )
      );
    }

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
          resizeToAvoidBottomInset: true,
          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
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
                                "Environment App Registration",
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
                        controller: _nameTextController,
                        keyboardType: TextInputType.text,
                        validator: (value){
                          if(value!.isEmpty){
                            return "Enter Full Name";
                          }
                          setState(() {
                            _nameTextController.text = value;
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
                            labelText: "Full Name",
                            prefixIcon: const Icon(Icons.person_3_sharp)
                        ),
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        controller: _emailTextController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value){
                          if(value!.isEmpty){
                            return "Enter Email";
                          }
                          final bool isValid = EmailValidator.validate(_emailTextController.text);
                          if(!isValid){
                            return "This Email is invalid";
                          }
                          setState(() {
                            _emailTextController.text = value;
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
                            labelText: "Email",
                            prefixIcon: const Icon(Icons.email_outlined)
                        ),
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        controller: _passwordTextController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Password";
                          }
                          if (value.length < 6) {
                            return "Your password is too short. Min 6 characters";
                          }
                          setState(() {
                            _passwordTextController.text = value;
                          });
                          return null;
                        },
                        obscureText: _visible == false ? true : false,
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
                            labelText: "Password",
                            prefixIcon: const Icon(Icons.vpn_key_outlined),
                            suffixIcon: IconButton(
                              icon: _visible ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _visible = !_visible;
                                });
                              },
                            )
                        ),
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        controller: _confirmpasswordTextController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Password";
                          }
                          if (value.length < 6) {
                            return "Your password is too short. Min 6 characters";
                          }
                          if(_passwordTextController.text != _confirmpasswordTextController.text){
                            return "Your passwords do not match";
                          }
                          setState(() {
                            _confirmpasswordTextController.text = value;
                          });
                          return null;
                        },
                        obscureText: _visible == false ? true : false,
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
                            labelText: "Confirm Password",
                            prefixIcon: const Icon(Icons.vpn_key_outlined),
                            suffixIcon: IconButton(
                              icon: _visible ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _visible = !_visible;
                                });
                              },
                            )
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
                              authData.registerUser(_emailTextController.text, _passwordTextController.text).then((credential){
                                if(credential?.user?.uid != null){
                                  authData.saveUserDataToDb(
                                    name: _nameTextController.text,
                                    emailaddress: _emailTextController.text
                                  ).then((value){
                                    setState(() {
                                      _formKey.currentState?.reset();

                                    });
                                    Navigator.pushReplacementNamed(context, HomeScreen.id);
                                  });
                                } else {
                                  scaffoldMessage(authData.error);
                                  Navigator.pushReplacementNamed(context, RegisterScreen.id);
                                }
                              });
                            }
                          },
                          child: const Text(
                            "REGISTER",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        child: TextButton(
                          child: const Text("Login Instead"),
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, LoginScreen.id);
                          },
                        ),
                      )
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
