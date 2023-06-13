import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash-screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  width: 300,
                  child: Image.asset('images/safari_rally_logo.png')
              ),
              const SizedBox(height: 20,),
              const Text(
                'Safari Rally Environment Sustainability Application',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              )
            ],
          )
      ),
    );
  }
}
